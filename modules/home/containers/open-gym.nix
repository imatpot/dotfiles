{
  outputs,
  config,
  osConfig,
  pkgs,
  ...
}:
outputs.lib.mkModule config false "containers.open-gym"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.open-gym.dirs.root is not set";
    };
  };

  domain = outputs.lib.mkOption {
    type = outputs.lib.types.nullOr outputs.lib.types.str;
    default = null;
  };

  adminUids = outputs.lib.mkOption {
    type = outputs.lib.types.listOf outputs.lib.types.str;
    default = [];
  };

  inviteOnly = outputs.lib.mkOption {
    type = outputs.lib.types.bool;
    default = false;
  };
}
(
  let
    cfg = config.modules.containers.open-gym;

    webPort = 8090;

    repo = "https://github.com/DuarteSantos8/openGym";

    backend = osConfig.virtualisation.oci-containers.backend;

    backendPackage =
      if backend == "docker"
      then osConfig.virtualisation.docker.package
      else osConfig.virtualisation.podman.package;

    # Every published image is built from the API's `default` target, which omits
    # the Claude Agent SDK. The AI coach needs it, and upstream only ever builds
    # that locally, so open-gym-api-image does so before the container starts -
    # as often as `pull = "newer"` would fetch a new one.
    apiImage = "localhost/opengym-api";
    apiImageTag = "${apiImage}:claude";

    # Upstream's `coach` target is the Claude Agent SDK *and* the Codex CLI with
    # its bubblewrap sandbox. Only Claude is used here, so this takes the `base`
    # stage both targets share and adds Claude's half on its own: the SDK is an
    # optional dependency, and `base` is the one that skips those.
    claudeDockerfile = pkgs.writeText "opengym-api-claude.Dockerfile" ''
      ARG BASE
      FROM ''${BASE}
      RUN npm ci --omit=dev && npm cache clean --force
    '';

    apiDataDir = "${cfg.dirs.root}/data/open-gym-api/data";
    mediaImgDir = "${cfg.dirs.root}/data/open-gym-media/img";
    mediaGifDir = "${cfg.dirs.root}/data/open-gym-media/gif";

    rpId =
      if cfg.domain == null
      then "localhost"
      else cfg.domain;

    origin =
      if cfg.domain == null
      then "http://localhost:${toString webPort}"
      else "https://${cfg.domain}";
  in {
    nixos = {
      system.ensureDirectories = [
        apiDataDir
        mediaImgDir
        mediaGifDir
      ];

      systemd.services.open-gym-api-image = {
        description = "Build the openGym API image with the Claude Agent SDK";

        before = ["${backend}-open-gym-api.service"];
        requiredBy = ["${backend}-open-gym-api.service"];

        wants = ["network-online.target"];
        after = ["network-online.target"];

        path = [
          backendPackage
          pkgs.gitMinimal
        ];

        # Not RemainAfterExit, so that every start of the container re-checks
        # upstream, just like the pull policy of the other containers does.
        serviceConfig = {
          Type = "oneshot";
          TimeoutStartSec = "1h";
        };

        script = ''
          rev="$(git ls-remote ${repo} HEAD | cut -f1 || true)"

          # Unreachable upstream keeps whatever was built last, rather than
          # taking the container down with it.
          if [ -z "$rev" ]; then
            ${backend} image inspect ${apiImageTag} > /dev/null
            exit 0
          fi

          base="${apiImage}:base-$rev"
          image="${apiImage}:claude-$rev"

          if ! ${backend} image inspect "$image" > /dev/null 2>&1; then
            src="$(mktemp -d)"
            trap 'rm -rf "$src"' EXIT

            git clone --quiet --depth 1 ${repo} "$src"
            # OCI format, which drops the HEALTHCHECK the API declares. Keeping
            # it only earns a failed transient unit per probe - podman runs them
            # through systemd-run, upstream sets no start period, so the first
            # one fires before node listens - and nothing here reads the status.
            ${backend} build --target base --tag "$base" "$src/api"
            ${backend} build --build-arg BASE="$base" --file ${claudeDockerfile} --tag "$image" "$src/api"
          fi

          ${backend} tag "$image" ${apiImageTag}

          # The revision tags of everything older. Matching on the tag rather
          # than on the image keeps ${apiImageTag} itself out of it - it names
          # the same image as $image, so a reference filter would list it here
          # and the container would lose the only tag it is allowed to run.
          ${backend} images --format '{{.Repository}}:{{.Tag}}' \
            | grep -E '^${apiImage}:(base|claude)-' \
            | grep -vx "$image" \
            | grep -vx "$base" \
            | xargs -r -n1 ${backend} rmi || true
        '';
      };

      virtualisation.oci-containers = {
        containers = {
          open-gym-media = {
            image = "docker.io/alpine/git";

            autoStart = true;
            autoRemoveOnStop = false;

            entrypoint = "/bin/sh";
            cmd = [
              "-c"
              ''
                if [ -z "$(ls -A /out/img 2>/dev/null)" ]; then
                  git clone --depth 1 https://github.com/hasaneyldrm/exercises-dataset /tmp/ds
                  cp /tmp/ds/images/*.jpg /out/img/ && cp /tmp/ds/videos/*.gif /out/gif/
                fi
              ''
            ];

            volumes = [
              "${mediaImgDir}:/out/img"
              "${mediaGifDir}:/out/gif"
            ];
          };

          open-gym-api = {
            image = apiImageTag;
            pull = "never";

            autoStart = true;
            autoRemoveOnStop = false;

            ports = [
              "${toString webPort}:80"
            ];

            environment =
              {
                PORT = "3000";
                DATA_DIR = "/data";
                RP_ID = rpId;
                ORIGIN = origin;
                ALLOW_GUEST = "0";
              }
              // outputs.lib.optionalAttrs (cfg.adminUids != []) {
                ADMIN_UIDS = outputs.lib.concatStringsSep "," cfg.adminUids;
              }
              // outputs.lib.optionalAttrs cfg.inviteOnly {
                INVITE_ONLY = "1";
              };

            volumes = [
              "${apiDataDir}:/data"
            ];
          };

          open-gym-web = {
            image = "ghcr.io/duartesantos8/opengym-web:edge";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            dependsOn = [
              "open-gym-media"
              "open-gym-api"
            ];

            networks = [
              "container:open-gym-api"
            ];

            environment = {
              NGINX_PORT = "80";
              BACKEND = "127.0.0.1";
              PORT = "3000";
            };

            volumes = [
              "${mediaImgDir}:/usr/share/nginx/html/img:ro"
              "${mediaGifDir}:/usr/share/nginx/html/gif:ro"
            ];
          };
        };
      };
    };
  }
)

{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.forgejo-runner"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.forgejo-runner.dirs.root is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.forgejo-runner;
    dataDir = "${cfg.dirs.root}/data/forgejo-runner/data";
  in {
    modules.containers = {
      dind.enable = outputs.lib.mkDefault true;
    };

    nixos = {
      system.ensureDirectories = [
        dataDir
      ];

      virtualisation.oci-containers = {
        containers = {
          forgejo-runner = {
            # No `latest` tag is published, only versions.
            image = "data.forgejo.org/forgejo/runner:13";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            user = "root";

            networks = ["container:dind"];
            dependsOn = ["dind"];

            environment = {
              DOCKER_HOST = "tcp://localhost:2375";
            };

            entrypoint = "/bin/sh";
            cmd = [
              "-c"
              ''
                if [ ! -f /data/runner-config.yml ]; then
                  forgejo-runner generate-config > /data/runner-config.yml
                fi
                exec forgejo-runner daemon --config /data/runner-config.yml
              ''
            ];

            volumes = [
              "${dataDir}:/data"
            ];
          };
        };
      };
    };
  }
)

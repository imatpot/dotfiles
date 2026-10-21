{
  outputs,
  config,
  osConfig,
  username,
  ...
}:
outputs.lib.mkModule config false "containers.wrtag"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.wrtag.dirs.root is not set";
    };

    music = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.wrtag.dirs.models is not set";
    };

    downloads = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.wrtag.dirs.nodes is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.wrtag;
    dataDir = "${cfg.dirs.root}/data/wrtag/data";
  in {
    sops.templates.wrtag-env.content = ''
      WRTAG_WEB_API_KEY=${config.sops.placeholder."containers/wrtag/api_key"}
    '';

    nixos = {
      system.ensureDirectories = [
        cfg.dirs.music
        cfg.dirs.downloads
        dataDir
      ];

      virtualisation.oci-containers = {
        containers = {
          wrtag = {
            image = "ghcr.io/sentriz/wrtag";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            ports = [
              "7373:7373"
            ];

            volumes = [
              "${dataDir}:/data"
              "${dataDir}/config:/config"
              "${cfg.dirs.music}:/music"
              "${cfg.dirs.downloads}:/downloads"
            ];

            environment = {
              # TODO: don't hardcode this
              PUID = "1000";
              PGID = "100";
              WRTAG_WEB_DB_PATH = "/data/wrtag.db";
              WRTAG_CONFIG_PATH = "/config";
            };

            environmentFiles = [
              config.sops.templates.wrtag-env.path
            ];
          };
        };
      };
    };
  }
)

{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.lidarr"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.lidarr.dirs.root is not set";
    };

    media = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.lidarr.dirs.media is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.lidarr;
    configDir = "${cfg.dirs.root}/data/lidarr/config";
  in {
    modules.containers = {
      gluetun.enable = outputs.lib.mkDefault true;
    };

    nixos = {
      system.ensureDirectories = [
        configDir
        cfg.dirs.media
      ];

      virtualisation.oci-containers = {
        containers = rec {
          lidarr = {
            image = "lscr.io/linuxserver/lidarr";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            networks =
              outputs.lib.mkIf
              config.modules.containers.gluetun.enable
              ["container:gluetun"];

            dependsOn =
              outputs.lib.mkIf
              config.modules.containers.gluetun.enable
              ["gluetun"];

            ports = [
              "8686:8686"
            ];

            environment = {
              PUID = "0";
              PGID = "0";
            };

            volumes = [
              "${configDir}:/config"
              "${cfg.dirs.media}:/data/media"
            ];
          };

          gluetun.ports =
            outputs.lib.optionals
            config.modules.containers.gluetun.enable
            lidarr.ports;
        };
      };
    };
  }
)

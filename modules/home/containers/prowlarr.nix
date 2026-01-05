{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.prowlarr"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.prowlarr.dirs.root is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.prowlarr;
    configDir = "${cfg.dirs.root}/data/prowlarr/config";
  in {
    modules.containers = {
      gluetun.enable = outputs.lib.mkDefault true;
    };

    nixos = {
      system.ensureDirectories = [
        configDir
      ];

      virtualisation.oci-containers = {
        containers = rec {
          prowlarr = {
            image = "lscr.io/linuxserver/prowlarr";
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
              "9696:9696"
            ];

            environment = {
              PUID = "0";
              PGID = "0";
            };

            volumes = [
              "${configDir}:/config"
            ];
          };

          gluetun.ports =
            outputs.lib.optionals
            config.modules.containers.gluetun.enable
            prowlarr.ports;
        };
      };
    };
  }
)

{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.jackett"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.jackett.dirs.root is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.jackett;
    configDir = "${cfg.dirs.root}/data/jackett/config";
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
          jackett = {
            image = "lscr.io/linuxserver/jackett";
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
              "9117:9117"
            ];

            environment = {
              AUTO_UPDATE = "true";
            };

            volumes = [
              "${configDir}:/config"
            ];
          };

          gluetun.ports =
            outputs.lib.optionals
            config.modules.containers.gluetun.enable
            jackett.ports;
        };
      };
    };
  }
)

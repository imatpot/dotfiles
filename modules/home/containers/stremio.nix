{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.stremio"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.stremio.dirs.root is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.stremio;
    configDir = "${cfg.dirs.root}/data/stremio/config";
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
          stremio = {
            image = "docker.io/stremio/server";
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
              "11470:11470"
              "12470:12470"
            ];

            environment = {
              NO_CORS = "1";
            };

            volumes = [
              # curl http://127.0.0.1:11470/get-https?ipAddress=127.0.0.1
              "${configDir}:/stremio/.stremio-server"
            ];
          };

          gluetun.ports =
            outputs.lib.optionals
            config.modules.containers.gluetun.enable
            stremio.ports;
        };
      };
    };
  }
)

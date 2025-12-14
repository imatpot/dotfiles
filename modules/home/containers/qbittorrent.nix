{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.qbittorrent"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.qbittorrent.dirs.root is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.qbittorrent;
    configDir = "${cfg.dirs.root}/data/qbittorrent/config";
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
          qbittorrent = {
            image = "lscr.io/linuxserver/qbittorrent";
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
              "8080:8080"
              "6881:6881"
              "6881:6881/udp"
            ];

            volumes = [
              "${configDir}:/config"
            ];
          };

          gluetun.ports =
            outputs.lib.optionals
            config.modules.containers.gluetun.enable
            qbittorrent.ports;
        };
      };
    };
  }
)

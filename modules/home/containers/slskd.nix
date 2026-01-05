{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.slskd"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.slskd.dirs.root is not set";
    };

    downloads = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.slskd.dirs.downloads is not set";
    };

    incompleteDownloads = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = config.modules.containers.slskd.dirs.downloads + "/.incomplete";
    };
  };
}
(
  let
    cfg = config.modules.containers.slskd;
    appDir = "${cfg.dirs.root}/data/slskd/app";
  in {
    modules.containers = {
      gluetun.enable = outputs.lib.mkDefault true;
    };

    nixos = {
      system.ensureDirectories = [
        appDir
        cfg.dirs.downloads
        cfg.dirs.incompleteDownloads
      ];

      virtualisation.oci-containers = {
        containers = rec {
          slskd = {
            image = "ghcr.io/slskd/slskd";
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
              "5030:5030"
              "50300:50300"
            ];

            environment = {
              SLSKD_REMOTE_CONFIGURATION = "true";
            };

            volumes = [
              "${appDir}:/app"
              "${cfg.dirs.downloads}:/downloads"
              "${cfg.dirs.incompleteDownloads}:/incomplete"
            ];
          };

          gluetun.ports =
            outputs.lib.optionals
            config.modules.containers.gluetun.enable
            slskd.ports;
        };
      };
    };
  }
)

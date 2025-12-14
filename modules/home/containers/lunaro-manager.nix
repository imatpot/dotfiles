{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.lunaro-manager"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.lunaro-manager.dirs.root is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.lunaro-manager;
    logDir = "${cfg.dirs.root}/data/lunaro-manager/log";
    dataDir = "${cfg.dirs.root}/data/lunaro-manager/data";
  in {
    nixos = {
      system.ensureDirectories = [
        logDir
        dataDir
      ];

      virtualisation.oci-containers = {
        containers = {
          lunaro-manager = {
            image = "ghcr.io/imatpot/lunaro-manager";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            environment = {
              LOG_DIR = "log";
              DATA_DIR = "data";
            };

            environmentFiles = [
              (cfg.dirs.root + "/.env")
            ];

            volumes = [
              "${logDir}:/app/log"
              "${dataDir}:/app/data"
            ];
          };
        };
      };
    };
  }
)

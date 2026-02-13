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
    sops.templates.gluetun-env.content = ''
      CLIENT_ID=${config.sops.placeholder."containers/lunaro-manager/client_id"}
      CLIENT_TOKEN=${config.sops.placeholder."containers/lunaro-manager/client_token"}
      HOME_GUILD_ID=${config.sops.placeholder."containers/lunaro-manager/home_guild_id"}
      PLAYING_ROLE_ID=${config.sops.placeholder."containers/lunaro-manager/playing_role_id"}
    '';

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
              config.sops.templates.gluetun-env.path
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

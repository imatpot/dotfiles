{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.jellyfin"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.jellyfin.dirs.root is not set";
    };

    media = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.jellyfin.dirs.media is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.jellyfin;
    configDir = "${cfg.dirs.root}/data/jellyfin/config";
    cacheDir = "${cfg.dirs.root}/data/jellyfin/cache";
  in {
    nixos = {
      system.ensureDirectories = [
        configDir
        cacheDir
      ];

      virtualisation.oci-containers = {
        containers = {
          jellyfin = {
            image = "lscr.io/linuxserver/jellyfin";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            ports = [
              "8096:8096"
            ];

            devices = [
              "nvidia.com/gpu=all"
            ];

            volumes = [
              "${configDir}:/config"
              "${cacheDir}:/cache"
              "${cfg.dirs.media}:/data/media"
            ];
          };
        };
      };
    };
  }
)

{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config false "containers.dind"
{
  dirs = {
    root = outputs.lib.mkOption {
      type = outputs.lib.types.path;
      default = throw "dotfiles: containers.dind.dirs.root is not set";
    };
  };
}
(
  let
    cfg = config.modules.containers.dind;
    dataDir = "${cfg.dirs.root}/data/dind/docker";
  in {
    nixos = {
      system.ensureDirectories = [
        dataDir
      ];

      virtualisation.oci-containers = {
        containers = {
          dind = {
            image = "docker.io/library/docker:dind";
            pull = "newer";

            autoStart = true;
            autoRemoveOnStop = false;

            privileged = true;

            cmd = [
              "dockerd"
              "-H"
              "tcp://0.0.0.0:2375"
              "--tls=false"
            ];

            volumes = [
              "${dataDir}:/var/lib/docker"
            ];
          };
        };
      };
    };
  }
)

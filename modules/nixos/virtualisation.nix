{
  outputs,
  config,
  lib,
  ...
}:
outputs.lib.mkModule config true "virtualisation" {
  backend = lib.mkOption {
    type = lib.types.str;
    default = "podman";
  };
} {
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    oci-containers.backend = lib.mkOptionDefault config.modules.virtualisation.backend;
  };
}

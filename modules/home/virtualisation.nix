{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "virtualisation"
{
  nixos.virtualisation = {
    docker.enable = true;
    oci-containers.backend = "podman";
  };
}

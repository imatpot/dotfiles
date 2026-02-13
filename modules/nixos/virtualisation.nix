{
  outputs,
  config,
  lib,
  pkgs,
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

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = lib.mkOptionDefault config.modules.virtualisation.backend;
  };

  environment = {
    variables = {
      PODMAN_COMPOSE_WARNING_LOGS = "false";
      PODMAN_COMPOSE_PROVIDER =
        if config.modules.virtualisation.backend == "podman"
        then lib.getExe pkgs.podman-compose
        else null;
    };

    systemPackages = with pkgs; [
      docker-compose
      podman-compose
    ];
  };
}

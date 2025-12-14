{
  outputs,
  system,
  hostname,
  config,
  ...
}:
outputs.lib.mkConfigModule config true "virtualisation"
<| outputs.lib.mkFor system hostname
{
  systems.linux = {
    nixos.modules.virtualisation.enable = true;
    services.podman = {
      enable = true;
      enableTypeChecks = true;
    };
  };
}

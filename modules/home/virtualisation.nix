{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config true "virtualisation"
{
  nixos.modules.virtualisation.enable = true;
}

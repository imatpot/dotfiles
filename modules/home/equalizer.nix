{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "equalizer"
{
  services.easyeffects.enable = true;
}

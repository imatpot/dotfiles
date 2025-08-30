{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "sunshine" {
  nixos.services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };
}

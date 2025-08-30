{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config (!config.modules.gui.enable) "systemd-boot" {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
}

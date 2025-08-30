{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "logitech" {
  hardware.logitech.wireless.enable = true;
  services.ratbagd.enable = true;
  environment.systemPackages = outputs.lib.optionals config.modules.gui.enable (with pkgs; [
    piper
  ]);
}

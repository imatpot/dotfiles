{
  outputs,
  system,
  hostname,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gaming.enable "gaming.wine" (outputs.lib.mkFor system hostname {
  systems.linux = {
    home.packages = with pkgs;
      [
        (bottles.override {removeWarningPopup = true;})
      ]
      ++ (
        if config.modules.wayland.enable
        then [wine-wayland]
        else [wine]
      );
  };
})

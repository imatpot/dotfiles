{
  outputs,
  config,
  osConfig,
  ...
}:
outputs.lib.mkOptionsModule config "gui" {
  enable = outputs.lib.mkDefaultEnableOption <| osConfig.modules.gui.enable or false;

  wallpaper = outputs.lib.mkOption {
    type = outputs.lib.types.path;
    default = ./images/wallpaper.default.png;
    description = "Path to the wallpaper.";
  };
}

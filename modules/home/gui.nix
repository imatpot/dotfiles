{
  outputs,
  config,
  osConfig,
  ...
}:
outputs.lib.mkOptionsModule config "gui" {
  enable = outputs.lib.mkDefaultEnableOption (
    if osConfig ? modules.gui.enable
    then osConfig.modules.gui.enable
    else false
  );

  wallpaper = outputs.lib.mkOption {
    type = outputs.lib.types.path;
    default = ./images/wallpaper.default.png;
    description = "Path to the wallpaper.";
  };
}

{
  outputs,
  config,
  ...
}:
outputs.lib.mkOptionsModule config false "gui" {
  wallpaper = outputs.lib.mkOption {
    type = outputs.lib.types.path;
    default = ./images/wallpaper.default.png;
    description = "Path to the wallpaper.";
  };
}

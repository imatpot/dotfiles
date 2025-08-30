{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "video" {
  home.packages = with pkgs;
    [
      ffmpeg
    ]
    ++ outputs.lib.optionals config.modules.gui.enable [
      vlc
      obs-studio
    ];
}

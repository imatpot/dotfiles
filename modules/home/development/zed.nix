{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "dev.zed"
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor-fhs;
  };

  home.shellAliases.zed = "zeditor";
  stylix.targets.zed.enable = false;
}

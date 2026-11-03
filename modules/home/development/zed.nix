{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "dev.zed"
{
  programs.zed-editor.enable = true;
  nixos.programs.nix-ld.enable = true;

  home.shellAliases.zed = "zeditor";
  stylix.targets.zed.enable = false;
}

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "zotero"
{
  home.packages = with pkgs; [
    zotero
  ];
}

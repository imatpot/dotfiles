{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "zotero"
{
  home.packages = with pkgs; [
    master.zotero
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "firefox-esr-140-bin-unwrapped-140.17.0esr"
  ];
}

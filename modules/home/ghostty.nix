{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "ghostty" {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    installBatSyntax = true;

    settings = {
      adjust-cell-height = "15%";
      background-blur = 20;
      window-padding-x = 8;
      window-padding-y = 8;
      window-inherit-working-directory = false;
    };

    themes.stylix = {
      background = "#080808";
    };
  };
}

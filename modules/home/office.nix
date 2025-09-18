{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "office"
{
  programs.onlyoffice = {
    enable = true;
    settings = {
      UITheme = "theme-contrast-dark";
    };
  };
}

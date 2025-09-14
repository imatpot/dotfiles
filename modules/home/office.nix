{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "office"
{
  programs.onlyoffice = {
    enable = true;
    settings =
      # ini
      ''
        [General]
        UITheme=theme-contrast-dark
      '';
  };
}

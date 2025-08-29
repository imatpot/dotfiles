{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config config.modules.gui.enable "zen-browser"
{
  home.packages = with pkgs; [zen-browser];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      entries = [
        "${pkgs.zen-browser}/share/applications/zen.desktop"
        "zen.desktop"
      ];
    in {
      "default-web-browser" = entries;
      "text/html" = entries;
      "x-scheme-handler/http" = entries;
      "x-scheme-handler/https" = entries;
      "x-scheme-handler/about" = entries;
      "x-scheme-handler/unknown" = entries;
    };
  };
}

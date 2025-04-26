{ inputs, outputs, config, system, pkgs, ... }:

{
  options = {
    modules.users.zen-browser.enable =
      outputs.lib.mkEnableOption "Enable Zen Browser";
  };

  config = outputs.lib.mkIf config.modules.users.zen-browser.enable {
    nixpkgs.overlays = [
      (_: _: { zen-browser = inputs.zen-browser.packages.${system}.default; })
    ];

    home.packages = with pkgs; [ zen-browser ];

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
  };
}

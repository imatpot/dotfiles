{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.discord.enable =
      outputs.lib.mkEnableOption "Enable Discord/Vesktop (Wayland)";
  };

  # Krisp: https://github.com/NixOS/nixpkgs/issues/195512

  config = outputs.lib.mkIf config.modules.users.discord.enable {
    home.packages = with pkgs;
      if (outputs.lib.isWayland config) then
        [ unstable.vesktop ]
      else
        [ unstable.discord ];

    nixpkgs = {
      overlays = [
        (_: prev: {
          discord = prev.discord.override {
            withOpenASAR = true;
            withVencord = true;
          };

          vesktop = prev.symlinkJoin {
            name = "vesktop";
            paths = [
              (prev.writeShellScriptBin "vesktop" ''
                exec ${prev.vesktop}/bin/vesktop \
                  --enable-features=UseOzonePlatform,WaylandWindowDecorations \
                  --ozone-platform-hint=auto \
                  --ozone-platform=wayland \
                  "$@"
              '')
              prev.vesktop
            ];
          };
        })
      ];
    };
  };

}

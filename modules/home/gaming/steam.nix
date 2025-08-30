{
  outputs,
  system,
  hostname,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule config config.modules.gaming.enable "gaming.steam"
{
  gamescope.enable = outputs.lib.mkDefaultEnableOption true;
}
(outputs.lib.mkFor system hostname
  {
    systems.linux = let
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
    in {
      nixos.programs.steam = {
        enable = true;
        gamescopeSession.enable = config.modules.gaming.steam.gamescope.enable;
      };

      home = {
        packages = with pkgs; [
          protonup
        ];

        sessionVariables = {
          inherit STEAM_EXTRA_COMPAT_TOOLS_PATHS;
        };

        activation.protonup =
          outputs.lib.hm.dag.entryAfter ["writeBoundary"]
          # bash
          ''
            if [ ! -d "${STEAM_EXTRA_COMPAT_TOOLS_PATHS}" ]; then
              yes | ${pkgs.protonup}/bin/protonup
            fi
          '';
      };
    };
  })

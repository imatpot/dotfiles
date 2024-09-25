{ inputs, outputs, config, pkgs, system, hostname, name, ... }:

let
  STEAM_EXTRA_COMPAT_TOOLS_PATHS =
    "/home/${name}/.steam/root/compatibilitytools.d";

in {
  options = {
    modules.users.gaming.enable =
      outputs.lib.mkEnableOption "Enable gaming setup on NixOS";
  };

  config = outputs.lib.mkIf config.modules.users.gaming.enable
    (outputs.lib.mkFor system hostname {
      systems.linux = {
        home = {
          packages = (with pkgs; [ protonup lutris bottles prismlauncher ])
            ++ (with inputs.nix-gaming.packages.${system};
              [
                # TODO: fix why this compiles instead of using a cache
                # wine-ge
                # wine-discord-ipc-bridge
              ]);

          sessionVariables = { inherit STEAM_EXTRA_COMPAT_TOOLS_PATHS; };

          activation = {
            # Run protonup once
            protonup = outputs.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              if [ ! -d "${STEAM_EXTRA_COMPAT_TOOLS_PATHS}" ]; then
                yes | ${pkgs.protonup}/bin/protonup
              fi
            '';
          };
        };

        nixos = {
          hardware.graphics.enable = true;

          programs = {
            steam = {
              enable = true;
              gamescopeSession.enable = true;
            };
            gamemode.enable = true;
          };
        };
      };
    });
}

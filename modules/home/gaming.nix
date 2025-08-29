{
  inputs,
  outputs,
  config,
  pkgs,
  system,
  hostname,
  ...
}: let
  STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
in {
  options = {
    modules.users.gaming = {
      wine.enable = outputs.lib.mkEnableOption "Enable Wine";
      proton.enable = outputs.lib.mkEnableOption "Enable Proton";
      steam.enable = outputs.lib.mkEnableOption "Enable Steam";
      lutris.enable = outputs.lib.mkEnableOption "Enable Lutris";

      games = {
        minecraft.enable = outputs.lib.mkEnableOption "Enable Minecraft";
        pokemmo.enable = outputs.lib.mkEnableOption "Enable PokeMMO";
      };
    };
  };

  config = let
    # TODO: awful, can i use != null or something?
    isGamingEnabled =
      config.modules.users.gaming.wine.enable
      || config.modules.users.gaming.proton.enable
      || config.modules.users.gaming.steam.enable
      || config.modules.users.gaming.lutris.enable
      || config.modules.users.gaming.games.minecraft.enable
      || config.modules.users.gaming.games.pokemmo.enable;
  in (outputs.lib.mkFor system hostname {
    systems.linux = {
      home = {
        packages = let
          # TODO: awful formatting
          winePkgs = outputs.lib.optionals config.modules.users.gaming.wine.enable (
            (with pkgs; [bottles])
            ++ (with inputs.nix-gaming.packages.${system}; [
              # TODO: fix why this compiles instead of using a cache
              # wine-ge
              # wine-discord-ipc-bridge
            ])
          );
          protonPkgs = outputs.lib.optionals config.modules.users.gaming.proton.enable (
            with pkgs; [protonup]
          );
          lutrisPkgs = outputs.lib.optionals config.modules.users.gaming.lutris.enable (
            with pkgs; [lutris]
          );
          minecraftPkgs = outputs.lib.optionals config.modules.users.gaming.games.minecraft.enable (
            with pkgs; [prismlauncher]
          );
          pokemmoPkgs = outputs.lib.optionals config.modules.users.gaming.games.pokemmo.enable (
            with pkgs; [pokemmo-installer]
          );
        in
          winePkgs ++ protonPkgs ++ lutrisPkgs ++ minecraftPkgs ++ pokemmoPkgs;

        sessionVariables = outputs.lib.mkIf config.modules.users.gaming.steam.enable {
          inherit STEAM_EXTRA_COMPAT_TOOLS_PATHS;
        };

        activation = {
          # Run protonup once
          protonup = outputs.lib.mkIf config.modules.users.gaming.proton.enable (
            outputs.lib.hm.dag.entryAfter ["writeBoundary"] ''
              if [ ! -d "${STEAM_EXTRA_COMPAT_TOOLS_PATHS}" ]; then
                yes | ${pkgs.protonup}/bin/protonup
              fi
            ''
          );
        };
      };

      nixos = {
        hardware.graphics.enable = outputs.lib.mkIf isGamingEnabled true;

        programs = {
          gamemode = {
            enable = outputs.lib.mkIf isGamingEnabled true;
            enableRenice = true;
            settings = {
              general = {
                softrealtime = "auto";
                renice = 10;
              };
            };
          };

          steam = outputs.lib.mkIf config.modules.users.gaming.steam.enable {
            enable = true;
            # gamescopeSession.enable = true;
          };
        };
      };
    };
  });
}

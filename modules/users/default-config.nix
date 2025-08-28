{
  outputs,
  pkgs,
  name,
  system,
  hostname,
  stateVersion,
  osConfig,
  config,
  ...
}:
with outputs.lib;
  mkFor system hostname {
    common = {
      imports = outputs.lib.enumeratePaths {
        path = ../../modules/users;
        exclude = [./default-config.nix];
      };

      home = {
        username = mkDefault name;
        stateVersion = mkDefault stateVersion;
        packages = with pkgs; [dots];

        sessionVariables = {
          NH_FLAKE = mkDefault config.programs.nh.flake;
          NIXPKGS_ALLOW_UNFREE = mkDefault (
            if config.nixpkgs.config.allowUnfree
            then 1
            else 0
          );
        };
      };

      programs = {
        vim.enable = mkDefault true;
        git.enable = mkDefault true;
        ssh.enable = mkDefault true;
        gpg.enable = mkDefault true;

        nh = {
          enable = mkDefault true;
          flake = "${config.home.homeDirectory}/.config/dotfiles";
          clean = {
            enable = mkDefault true;
            dates = mkDefault "weekly";
            extraArgs = mkDefault "--keep 3 --keep-since-7d";
          };
        };

        # Only needed on non-NixOS systems, also see `mkUser` in `lib/users.nix`.
        # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L18
        home-manager.enable = mkDefault (osConfig == null);
      };

      news.display = mkDefault "silent";
    };

    systems = {
      linux = {
        home.homeDirectory = mkDefault "/home/${name}";
      };

      darwin = {
        imports = [
          # TODO: Check back later if it compiles again
          # inputs.mac-app-util.homeManagerModules.default
        ];

        home.homeDirectory = mkDefault "/Users/${name}";
      };
    };
  }

{
  outputs,
  pkgs,
  system,
  hostname,
  username,
  osConfig,
  config,
  stateVersion,
  ...
}:
with outputs.lib;
  mkFor system hostname {
    common = {
      home = {
        inherit stateVersion;
        username = username;

        packages = with pkgs; [
          bat
          eza
          tldr
          jq
          watchexec
          just
          ncdu
        ];

        shellAliases = {
          mkcd = "fn() { mkdir -p $1 && cd $1; }; fn";
          ls = "eza";
          ll = "eza --all --classify --long --time-style long-iso";
          lll = "ll --total-size";
          tree = "ls --tree";
          ltree = "ll --tree";
          cat = "bat";
        };

        sessionVariables = {
          TLDR_AUTO_UPDATE_DISABLED = "1";
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

    systems.linux = {
      home.homeDirectory = outputs.lib.mkDefault "/home/${username}";

      nixos.users.users.${username} = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "docker"];
      };
    };

    systems.darwin = rec {
      home = {
        homeDirectory = outputs.lib.mkDefault "/Users/${username}";
        shellAliases.nix-rosetta = "nix --system x86_64-darwin";
      };

      macos.users.users.${username} = {
        createHome = true;
        home = home.homeDirectory;
      };
    };
  }

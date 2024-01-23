{ outputs, system, config, hostname, ... }:

outputs.lib.mkFor system hostname {
  common = {
    imports = [
      ../../modules/users/convenience.nix
      ../../modules/users/development.nix
      ../../modules/users/fonts.nix
      ../../modules/users/git.nix
      ../../modules/users/kitty.nix
      ../../modules/users/neovim.nix
      ../../modules/users/nix.nix
      ../../modules/users/sops.nix
      ../../modules/users/starship.nix
      ../../modules/users/writing.nix
      ../../modules/users/zsh.nix

      ./config/secrets.nix
    ];

    programs.git = {
      userName = "Mladen Branković";
      userEmail = "root@brankovic.dev";
    };
  };

  systems = {
    linux = {
      imports = [ ../../modules/users/discord.nix ];

      nixos.users.users.${config.home.username} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };

    darwin = {
      home.shellAliases.nix-rosetta = "nix --system x86_64-darwin";

      macos.users.users.${config.home.username} = {
        createHome = true;
        home = config.home.homeDirectory;
      };
    };
  };

  hosts = {
    mcdonalds = {
      programs.git = {
        userName = "Mladen Branković";
        userEmail = "mladen.brankovic@golog.ch";
        signing = {
          key = "588B95BE8E35DD34";
          signByDefault = true;
        };
      };
    };
  };
}

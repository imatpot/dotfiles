{ outputs, system, hostname, ... }:

outputs.lib.mkFor system hostname {
  common = {
    imports = [
      ../../modules/users/development.nix
      ../../modules/users/fonts.nix
      ../../modules/users/git.nix
      ../../modules/users/neovim.nix
      ../../modules/users/nix.nix
      ../../modules/users/sops.nix
      ../../modules/users/starship.nix
      ../../modules/users/writing.nix
      ../../modules/users/zsh.nix

      ./config/secrets.nix
    ];

    home = {
      shellAliases = rec {
        nix-gc = "nix-collect-garbage";

        shell = "nix shell";
        develop = "nix develop --command zsh";

        mkcd = "fn() { mkdir -p $1 && cd $1; }; fn";
        ll = "ls -la";

        python = "python3";
        py = python;
      };
    };

    programs.git = {
      userName = "Mladen Branković";
      userEmail = "root@brankovic.dev";
    };
  };

  systems = {
    linux = { imports = [ ../../modules/users/discord.nix ]; };
    darwin = { home.shellAliases.nix-rosetta = "nix --system x86_64-darwin"; };
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

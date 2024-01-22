{ pkgs, outputs, system, hostname, ... }:

outputs.lib.mkFor system hostname {
  common = {
    imports = [
      ../../modules/users/sops.nix
      ../../modules/users/nix.nix
      ../../modules/users/java.nix
      ../../modules/users/neovim.nix
      ../../modules/users/zsh.nix
      ../../modules/users/starship.nix
      ../../modules/users/git.nix
      ../../modules/users/fonts.nix

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

      packages = with pkgs; [
        bat
        flux
        neofetch
        tldr
        gnugrep
        nmap
        deno
        nodejs
        (with dotnetCorePackages; combinePackages [ sdk_6_0 sdk_7_0 ])
        graphviz
        kubectl
        cargo
        rustc
        typst
        poppler_utils
        android-tools
        watchexec
      ];
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

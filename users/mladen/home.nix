{ pkgs, outputs, system, hostname, ... }:

let
  common = {
    imports = [
      ../common/sops.nix
      ../common/nix.nix
      ../common/java.nix
      ../common/neovim.nix
      ../common/zsh.nix
      ../common/starship.nix

      ./config/secrets.nix

      (import ../common/git.nix {
        name = "Mladen Branković";

        email = if hostname == "mcdonalds" then
          "mladen.brankovic@golog.ch"
        else
          "root@brankovic.dev";

        signing = if hostname == "mcdonalds" then {
          key = "588B95BE8E35DD34";
          signByDefault = true;
        } else
          { };
      })
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
        cascadia-code
        fira-code
        inconsolata-nerdfont
        jetbrains-mono
        inriafonts
        libertine
        liberation_ttf
        atkinson-hyperlegible
        watchexec
      ];
    };
  };

  linux = {
    imports = if outputs.lib.isLinux system then [
      ../common/discord.nix
      ../common/vscode.nix
    ] else
      [ ];
  };

  darwin = {
    imports =
      if outputs.lib.isDarwin system then [ ../common/utm.nix ] else [ ];

    programs.zsh.shellAliases.nix-rosetta = "nix --system x86_64-darwin";
  };

in outputs.lib.deepMerge [ common linux darwin ]

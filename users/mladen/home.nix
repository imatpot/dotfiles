{ outputs, system, config, hostname, ... }:

outputs.lib.mkFor system hostname {
  common = {
    # TODO: Move this to lib/users.nix
    imports = outputs.lib.concatImports { path = ../../modules/users; };

    modules.users = {
      neovim.enable = true;
      zsh.enable = true;
      starship.enable = true;

      dev = {
        adb.enable = true;
        databases.enable = true;
        javascript.enable = true;
        plantuml.enable = true;
        python.enable = true;
        rust.enable = true;
        typst.enable = true;
      };
    };

    programs.git = {
      userName = "Mladen Branković";
      userEmail = "root@brankovic.dev";
    };
  };

  systems = {
    linux = {
      modules.users = {
        discord.enable = true;
        wayland.enable = true;
      };

      # TODO: Autogenerate in default default configs
      nixos.users.users.${config.home.username} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };

    darwin = {
      home.shellAliases.nix-rosetta = "nix --system x86_64-darwin";

      # TODO: Autogenerate in default default configs
      macos = {
        modules.users = {
          dev = {
            csharp.enable = true;
            java.enable = true;
            kubernetes.enable = true;
          };
        };

        users.users.${config.home.username} = {
          createHome = true;
          home = config.home.homeDirectory;
        };

        system.defaults = {
          NSGlobalDomain = { NSDocumentSaveNewDocumentsToCloud = false; };

          dock = {
            orientation = "left";
            tilesize = 32;

            # TODO: Check back later
            wvous-tl-corner = 1;
            wvous-br-corner = 1;
            wvous-tr-corner = 1;
            wvous-bl-corner = 1;
          };
        };
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

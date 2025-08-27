{
  outputs,
  config,
  pkgs,
  name,
  ...
}: let
  stylix-config = {
    enable = true;

    polarity = "dark";
    image = config.modules.users.wallpaper;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    targets = {
      kde.enable = false;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "CaskaydiaCove Nerd Font";
      };

      sansSerif = {
        package = pkgs.atkinson-hyperlegible-next;
        name = "Atkinson Hyperlegible Next";
      };

      serif = {
        package = pkgs.libertine;
        name = "Linux Libertine O";
      };

      sizes = {
        applications = 10;
        terminal = 10;
        desktop = 10;
        popups = 10;
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.9;
      desktop = 1.0;
      popups = 1.0;
    };

    base16Scheme = "${pkgs.master.base16-schemes}/share/themes/${config.modules.users.stylix.theme}.yaml";
  };

  settings = {
    user = {
      stylix = stylix-config;

      # This needs to always be set for the Stylix system configuation to be valid,
      # even if Stylix is disabled system-wide
      nixos.stylix.image = config.modules.users.wallpaper;

      gtk = {
        enable = true;
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
      };

      systemd.user.services.rm-gtk = {
        Unit = {
          Description = "Remove GTK files built by Home Manager";
          PartOf = ["home-manager-${name}.target"];
        };

        Service.ExecStart = builtins.toString (
          pkgs.writeShellScript "rm-gtk" ''
            #!/run/current-system/sw/bin/bash
            set -o errexit
            set -o nounset

            printf "Removing GTK files built by Home Manager\n"

            rm -rf ~/.config/gtk-3.0
            rm -rf ~/.config/gtk-4.0
            rm -f .gtkrc-2.0
          ''
        );

        Install.WantedBy = ["default.target"];
      };
    };

    system-wide = {
      stylix =
        stylix-config
        // {
          targets.grub.enable = false;
        };
    };
  };
in {
  options = {
    modules.users = {
      wallpaper = outputs.lib.mkOption {
        type = outputs.lib.types.path;
        default = ./images/wallpaper.default.png;
        description = "Path to the wallpaper.";
      };

      stylix = {
        enable = outputs.lib.mkEnableOption "Enable Stylix";
        system-wide = outputs.lib.mkEnableOption "Enable Stylix system-wide. This will install Stylix for all users.";

        # https://github.com/tinted-theming/schemes
        theme = outputs.lib.mkOption {
          type = outputs.lib.types.str;
          default = "selenized-black";
          description = "The Base16 theme to use.";
        };
      };
    };
  };

  config = outputs.lib.mkIf config.modules.users.stylix.enable (
    outputs.lib.mkMerge [
      (outputs.lib.mkIf config.modules.users.stylix.system-wide {
        nixos = outputs.lib.warn "dotfiles: enabling Stylix system-wide. This will override the configs of all users with ${name}'s config." settings.system-wide;
      })
      (outputs.lib.mkIf (!config.modules.users.stylix.system-wide) settings.user)
    ]
  );
}

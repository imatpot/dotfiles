{ outputs, system, hostname, config, pkgs, ... }:

let
  isGtk3DarkTheme = (config.gtk.gtk3.extraConfig
    ? gtk-application-prefer-dark-theme
    && config.gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme) == 1;

  isGtk4DarkTheme = (config.gtk.gtk4.extraConfig
    ? gtk-application-prefer-dark-theme
    && config.gtk.gtk4.extraConfig.gtk-application-prefer-dark-theme) == 1;

  isDarkTheme = isGtk3DarkTheme || isGtk4DarkTheme;

in {
  options = {
    modules.users.gnome.enable = outputs.lib.mkEnableOption "Enable Gnome";
  };

  config = outputs.lib.mkIf config.modules.users.gnome.enable {
    # Always start Gnome on Wayland
    # https://discourse.nixos.org/t/fix-gdm-does-not-start-gnome-wayland-even-if-it-is-selected-by-default-starts-x11-instead/24498
    nixos.services.displayManager.defaultSession =
      outputs.lib.mkIf config.modules.users.wayland.enable "gnome";

    gtk = {
      iconTheme = {
        name = if isDarkTheme then "Papirus-Dark" else "Papirus-Light";
        package = pkgs.papirus-icon-theme;
      };
    };

    dconf.settings = with outputs.lib.hm.gvariant;
      outputs.lib.mkFor system hostname {
        hosts.shinobi = {
          "org/gnome/desktop/peripherals/mouse" = { speed = -0.6; };
          "org/gnome/shell/extensions/quick-settings-tweaks" = {
            user-removed-buttons = [ "PowerProfilesToggle" "NMWiredToggle" ];
          };
        };

        common = {
          "org/gnome/desktop/wm/preferences" = {
            mouse-button-modifier = [ "<Super>" ];
          };

          "org/gnome/desktop/wm/keybindings" = {
            show-desktop = [ "<Super>d" ];
            switch-to-workspace-right = [ "<Super>Page_Up" ];
            switch-to-workspace-left = [ "<Super>Page_Down" ];
            panel-run-dialog = [ "<Super>r" ];
            toggle-fullscreen = [ "<Super>f" ];
          };

          "org/gnome/shell/keybindings" = {
            screenshot = [ "Print" ];
            show-screenshot-ui = [ "<Control>Print" ];
            show-screen-recording-ui = [ "<Shift><Control>Print" ];
            toggle-message-tray = [ "<Super>c" ];
          };

          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            enable-hot-corners = false;
          };

          "org/gnome/desktop/notifications" = { show-in-lock-screen = false; };

          "org/gnome/desktop/privacy" = {
            recent-files-max-age = 3;
            remove-old-temp-files = true;
          };

          "org/gnome/desktop/calendar" = {
            clock-show-date = true;
            show-weekdate = true;
          };

          "org/gnome/desktop/datetime" = { automatic-timezone = true; };

          "org/gnome/desktop/search-providers" = {
            sort-order = [
              "org.gnome.Contacts.desktop"
              "org.gnome.Documents.desktop"
              "org.gnome.Nautilus.desktop"
              "org.gnome.Settings.desktop"
              "org.gnome.Characters.desktop"
              "org.gnome.Calculator.desktop"
              "org.gnome.Calendar.desktop"
              "org.gnome.clocks.desktop"
              "org.gnome.seahorse.Application.desktop"
            ];

            disabled = [
              "org.gnome.Calendar.desktop"
              "org.gnome.clocks.desktop"
              "org.gnome.seahorse.Application.desktop"
            ];
          };

          "org/gnome/settings-daemon/plugins/power" = {
            sleep-inactive-ac-type = "nothing";
            power-button-action = "hibernate";
          };

          "org/gnome/settings-daemon/plugins/media-keys" = {
            control-center = [ "<Super>comma" ];
          };

          "org/gnome/mutter" = {
            edge-tiling = false; # We handle tiling with tiling-shell
            dynamic-workspaces = true;
          };

          "org/gnome/Console" = { audible-bell = false; };

          "org/gnome/shell" = {
            favorite-apps = [
              "org.gnome.Nautilus.desktop"
              "org.gnome.Console.desktop"
              "zen.desktop"
              "code.desktop"
              "vesktop.desktop"
            ];
          };

          "org/gnome/shell/extensions/system-monitor" = {
            show-swap = false;
            show-upload = false;
            show-download = false;
          };

          "org/gnome/shell/extensions/tilingshell" = {
            inner-gaps = mkUint32 0;
            outer-gaps = mkUint32 0;
            tilitng-system-activation-key = [ "0" ];
            span-multiple-tiles-activation-key = [ "1" ];
            restore-window-original-size = true;
            edge-tiling = true;
            top-edge-maximites = true;
          };

          "org/gnome/shell/extensions/vitals" = {
            position-in-panel = 4;
            menu-centered = true;
            icon-style = 1;
            hot-sensors = [ "_memory_usage_" "_processor_usage_" ];
          };

          "org/gnome/shell/extensions/dash-to-panel" = {
            hot-keys = true;
            appicon-margin = 0;
            appicon-padding = 4;
            animate-appicon-hover = true;
            dot-position = "TOP";
            dot-size = 2;
            dot-syle-unfocused = "DOTS";
            dot-style-focused = "DOTS";
            focus-highlight = true;
            focus-highlight-color = "#ffffff";
            focus-highlight-opacity = 10;
            isolate-locations = false;
            show-apps-icon-file = builtins.toString ./images/nix.white.png;
            show-apps-icon-side-padding = 8;

            show-window-previews-timeout = 250;
            leave-timeout = 0;

            animate-appicon-hover-animation = "{'SIMPLE': 0.1, 'RIPPLE': 0.4, 'PLANK': 0.0}";

            # TODO: This is not working despite dconf.nix suggesting it should: https://docs.gtk.org/glib/gvariant-text-format.html#dictionaries-and-dictionary-entries
            # animate-application-hover-animation-traver = {
            #   SIMPLE = 0.1;
            #   RIPPLE = 0.4;
            #   PLANK = 0.0;
            # };

            window-preview-size = 150;
            window-preview-padding = 0;
            window-preview-show-title = false;
            enter-peek-mode-timeout = 500;
            peek-mode-opacity = 50;

            panel-action = "CYCLE";

            panel-sizes = ''
              {
                "0": 32
              }
            '';

            panel-positions = ''
              {
                "0": "TOP"
              }
            '';

            panel-element-positions = ''
              {
                "0": [
                  { "element": "showAppsButton", "visible": true, "position": "stackedTL" },
                  { "element": "leftBox", "visible": true, "position": "stackedTL" },
                  { "element": "taskbar", "visible": true, "position": "stackedTL" },
                  { "element": "dateMenu", "visible": true, "position": "centerMonitor" },
                  { "element": "centerBox", "visible": true, "position": "stackedBR" },
                  { "element": "rightBox", "visible": true, "position": "stackedBR" },
                  { "element": "activitiesButton", "visible": true, "position": "stackedTL" },
                  { "element": "systemMenu", "visible": true, "position": "stackedBR" },
                  { "element": "desktopButton", "visible": false, "position": "stackedBR" }
                ]
              }
            '';
          };

          "org/gnome/shell/extensions/clipboard-indicator" = {
            cache-size = 10;
            preview-size = 80;
            history-size = 50;
            display-mode = 3;
            clear-on-boot = false;

            toggle-menu = [ "<Super>v" ];
            private-mode-bindings = [ "<Alt><Super>v" ];
            clear-historx = [ ];
            prev-entry = [ ];
            next-entry = [ ];
          };

          "org/gnome/shell/extensions/quick-settings-tweaks" = rec {
            notifications-enabled = true;
            notifications-max-height = 300;
            notifications-hide-when-no-notifications = true;
            datemenu-remove-notifications = notifications-enabled;

            media-control-enabled = true;
            media-control-compact-mode = false;
            datemenu-remove-media-control = media-control-enabled;

            volume-mixer-show-description = true;
            user-removed-buttons = [ "NightLightToggle" ];
          };

          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
              "user-theme@gnome-shell-extensions.gcampax.github.com"
              "drive-menu@gnome-shell-extensions.gcampax.github.com"
              "auto-move-windows@gnome-shell-extensions.gcampax.github.com" # TODO: stuff like Spotify
              "tilingshell@ferrarodomenico.com"
              "Vitals@CoreCoding.com"
              "dash-to-panel@jderose9.github.com"
              "clipboard-indicator@tudmotu.com"
              "quick-settings-tweaks@qwreey"
            ];
          };
        };
      };

    home.packages = with pkgs.gnomeExtensions; [
      user-themes
      tiling-shell
      vitals
      dash-to-panel
      clipboard-indicator
      quick-settings-tweaker
    ];
  };
}

{
  outputs,
  system,
  hostname,
  config,
  pkgs,
  ...
}: let
  isGtk3DarkTheme = (config.gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme or 0) == 1;
  isGtk4DarkTheme = (config.gtk.gtk4.extraConfig.gtk-application-prefer-dark-theme or 0) == 1;
  isDarkTheme = isGtk3DarkTheme || isGtk4DarkTheme;
in
  outputs.lib.mkConfigModule config config.modules.gui.enable "gnome"
  {
    nixos = {
      programs = {
        dconf.enable = true;
        ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/libexec/seahorse/ssh-askpass";
      };

      environment.gnome.excludePackages = with pkgs; [
        gnome-photos
        gnome-tour
        gedit
        gnome-music
        epiphany
        geary
        tali
        iagno
        hitori
        atomix
        yelp
        gnome-contacts
        gnome-initial-setup
      ];

      services = {
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;

        # Always start Gnome on Wayland
        # https://discourse.nixos.org/t/fix-gdm-does-not-start-gnome-wayland-even-if-it-is-selected-by-default-starts-x11-instead/24498
        displayManager.defaultSession = outputs.lib.mkIf config.modules.wayland.enable "gnome";
      };
    };

    gtk = {
      iconTheme = {
        name =
          if isDarkTheme
          then "Papirus-Dark"
          else "Papirus-Light";
        package = pkgs.papirus-icon-theme;
      };
    };

    dconf.settings = with outputs.lib.hm.gvariant;
      outputs.lib.mkFor system hostname {
        hosts.shinobi = {
          "org/gnome/desktop/peripherals/mouse" = {
            speed = 0;
          };

          "org/gnome/shell/extensions/quick-settings-tweaks" = {
            user-removed-buttons = [
              "PowerProfilesToggle"
              "NMWiredToggle"
            ];
          };

          "org/gnome/shell/extensions/tilingshell" = {
            # on a 21:9 monitor, this is
            # - 4:3 + 2 vertical
            # - 16:9 + 2 veritcal
            # - even thirds
            layouts-json = ''
              [
                {
                  "id": "7548829",
                  "tiles": [
                    { "x": 0, "y": 0, "width": 0.545639534883721, "height": 1, "groups": [1] },
                    { "x": 0.545639534883721, "y": 0, "width": 0.4543604651162786, "height": 0.5, "groups": [2, 1] },
                    { "x": 0.545639534883721, "y": 0.5, "width": 0.4543604651162786, "height": 0.5, "groups": [2, 1] }
                  ]
                },
                {
                  "id": "7706768",
                  "tiles": [
                    { "x": 0, "y": 0, "width": 0.7276162790697674, "height": 1, "groups": [1] },
                    { "x": 0.7276162790697674, "y": 0, "width": 0.2723837209302325, "height": 0.5, "groups": [2, 1] },
                    { "x": 0.7276162790697674, "y": 0.5, "width": 0.2723837209302325, "height": 0.5, "groups": [2, 1] }
                  ]
                },
                {
                  "id": "7789749",
                  "tiles": [
                    { "x": 0, "y": 0, "width": 0.33313953488372094, "height": 1, "groups": [1] },
                    { "x": 0.33313953488372094, "y": 0, "width": 0.3337209302325581, "height": 1, "groups": [2, 1] },
                    { "x": 0.666860465116279, "y": 0, "width": 0.3331395348837209, "height": 1, "groups": [2] }
                  ]
                }
              ]
            '';
          };
        };

        common = {
          "org/gnome/desktop/wm/preferences" = {
            mouse-button-modifier = ["<Super>"];
          };

          "org/gnome/desktop/wm/keybindings" = {
            show-desktop = ["<Super>d"];
            switch-to-workspace-right = ["<Super>Page_Up"];
            switch-to-workspace-left = ["<Super>Page_Down"];
            panel-run-dialog = ["<Super>r"];
            toggle-fullscreen = ["<Super>f"];
          };

          "org/gnome/shell/keybindings" = {
            screenshot = ["Print"];
            show-screenshot-ui = ["<Control>Print"];
            show-screen-recording-ui = ["<Shift><Control>Print"];
            toggle-message-tray = ["<Super>c"];
          };

          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            enable-hot-corners = false;
          };

          "org/gnome/desktop/notifications" = {
            show-in-lock-screen = false;
          };

          "org/gnome/desktop/privacy" = {
            recent-files-max-age = 3;
            remove-old-temp-files = true;
          };

          "org/gnome/desktop/calendar" = {
            clock-show-date = true;
            show-weekdate = true;
          };

          "org/gnome/desktop/datetime" = {
            automatic-timezone = true;
          };

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
            control-center = ["<Super>comma"];
            search = ["<Super>space"];
            custom-keybinds = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kgx/"
            ];
          };

          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kgx" = {
            name = "Console";
            command = "kgx";
            binding = "<Super>Return";
          };

          "org/gnome/mutter" = {
            edge-tiling = false; # handled by tiling-shell
            dynamic-workspaces = true;
          };

          "org/gnome/Console" = {
            audible-bell = false;
            custom-font = "CaskaydiaMono Nerd Font 10";
          };

          "org/gnome/shell" = {
            favorite-apps = [
              "org.gnome.Nautilus.desktop"
              "com.mitchellh.ghostty.desktop"
              "zen.desktop"
              "dev.zed.Zed.desktop"
              "code.desktop"
              "element-desktop.desktop"
              "vesktop.desktop"
              "feishin.desktop"
              "spotify.desktop"
              "QtScrcpy.desktop"
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
            tilitng-system-activation-key = ["0"];
            span-multiple-tiles-activation-key = ["1"];
            restore-window-original-size = true;
            edge-tiling = true;
            top-edge-maximites = true;
          };

          "org/gnome/shell/extensions/vitals" = {
            position-in-panel = 4;
            menu-centered = true;
            icon-style = 1;
            hot-sensors = [
              "_memory_usage_"
              "_processor_usage_"
            ];
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
            show-apps-icon-file = builtins.toString ./images/icons/nix.png;
            show-apps-icon-side-padding = 8;
            trans-use-custom-bg = true;
            trans-use-custom-opacity = true;
            trans-panel-opacity = 0;

            show-window-previews-timeout = 250;
            leave-timeout = 0;

            animate-appicon-hover-animation = "{'SIMPLE': 0.1, 'RIPPLE': 0.4, 'PLANK': 0.0}";

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
            display-mode = 0;
            clear-on-boot = false;

            toggle-menu = ["<Super>v"];
            private-mode-bindings = ["<Alt><Super>v"];
            clear-historx = [];
            prev-entry = [];
            next-entry = [];
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
            user-removed-buttons = ["NightLightToggle"];
          };

          "org/gnome/shell/extensions/hibernate-status-button" = {
            show-hybrid-sleep = false;
            show-suspend-then-hibernate = false;

            show-hibernate-dialog = true;
            show-hybrid-sleep-dialog = false;
            show-suspend-then-hibernate-dialog = false;
          };

          "org/gnome/desktop/app-folders/folders/Utilities" = {
            apps = [];
          };

          "org/gnome/shell/extensions/blur-my-shell/applications" = {
            blur = true;
            sigma = 20;
            opacity = 255;
            dynamic-opacity = false;
            whitelist = [
              "org.gnome.Console"
              "com.mitchellh.ghostty"
            ];
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
              "AlphabeticalAppGrid@stuarthayhurst"
              "hibernate-status@dromi"
              "blur-my-shell@aunetx"
            ];
          };
        };
      };

    home = {
      packages = with pkgs;
        [
          gnome-tweaks
        ]
        ++ (with pkgs.gnomeExtensions; [
          user-themes
          tiling-shell
          vitals
          dash-to-panel
          clipboard-indicator
          quick-settings-tweaker
          alphabetical-app-grid
          hibernate-status-button
          blur-my-shell
        ]);

      # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1278954466
      sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
        outputs.lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
        (
          with pkgs.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
            gst-plugins-ugly
            gst-libav
          ]
        );
    };
  }

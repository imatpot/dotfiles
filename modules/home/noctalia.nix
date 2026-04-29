{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "noctalia" {
  programs.noctalia-shell = {
    enable = true;

    settings = {
      dock.enabled = false;

      # TODO: replace with e.g. https://github.com/vicinaehq/vicinae
      appLauncher = {
        enableClipboardHistory = true;
      };

      location = {
        firstDayofWeek = 0;
        name = "Bern, Switzerland";
        showWeekNumberInCalendar = true;
        weatherShowEffects = false;
      };

      general = {
        allowPasswordWithFprintd = true;
        autoStartAuth = true;
        compactLockScreen = true;
        enableLockScreenCountdown = false;
        enableShadows = false;
        showHibernateOnLockScreen = true;
      };

      widgets = {
        left = [
          {
            id = "Workspace";
          }
          {
            id = "Taskbar";
          }
        ];

        center = [
          {
            id = "Clock";
            formatHorizontal = "MMM dd HH:mm:ss";
            formatVertical = "HH mm ss — dd MM";
            tooltipFormat = "HH:mm ddd, MMM dd";
          }
        ];

        right = [
          {
            id = "MediaMini";
            hideMode = "idle";
            maxWidth = 300;
            showProgressRing = false;
          }
          {
            id = "Tray";
            drawerEnabled = true;
          }
          {
            id = "SystemMonitor";
            compactMode = false;
            showDiskAsFree = false;
            showMemoryAsPercent = true;
          }
          {
            id = "Network";
            displayMode = "onhover";
          }
          {
            id = "Volume";
            displayMode = "alwaysShow";
            middleClickCommand =
              outputs.lib.mkIf config.modules.equalizer.enable <| outputs.lib.getExe pkgs.easyeffects;
          }
          {
            id = "ControlCenter";
            useDistroLogo = true;
            enableColorization = true;
            colorizeDistroLogo = true;
          }
        ];
      };

      controlCenter = {
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "Notifications"; }
          ];

          right = [
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };
      };

      sessionMenu = {
        enableCountdown = false;
      };

      notifications = {
        location = "top";
        criticalUrgencyDuration = 30;
        normalUrgencyDuration = 5;
        lowUrgencyDuration = 3;
      };

      systemMonitor = {
        systemMonitor = {
          batteryCriticalThreshold = 5;
          batteryWarningThreshold = 15;
        };
      };
      
      wallpaper = {
        skipStartupTransition = true;
      };
    };

    # TODO: translate non-standard and non-stylix-ocnflicting configs into plain Nix
    # TODO: somethign like nix shell nixpkgs#json-diff -c bash -c "json-diff <(jq -S . ~/.config/noctalia/settings.json) <(noctalia-shell ipc call state all | jq -S .settings)"
    # settings = {
    #   inherit (outputs.lib.fromJSON (outputs.lib.readFile ./noctalia.json))
    #     bar
    #     general
    #     location
    #     calendar
    #     appLauncher
    #     systemMonitor
    #     dock
    #     network
    #     sessionMenu
    #     notifications
    #     osd
    #     audio
    #     brightness
    #     templates
    #     nightLight
    #     hooks
    #     desktopWidgets
    #     ;
    # };
  };
}

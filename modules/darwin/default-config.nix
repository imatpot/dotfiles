{ outputs, pkgs, hostname, stateVersion, ... }:

with outputs.lib;

{
  system.stateVersion = mkDefault stateVersion;
  networking.hostName = mkDefault hostname;

  time.timeZone = mkDefault "Europe/Zurich";

  environment.systemPackages = with pkgs; [ vim git wget curl ];

  services.nix-daemon.enable = mkDefault true;

  nix = {
    gc = {
      automatic = mkDefault true;
      options = mkDefault "--delete-older-than 14d";
    };
  };

  system = {
    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = mkDefault 10.0;

      LaunchServices.LSQuarantine = mkDefault false;

      NSGlobalDomain = {
        AppleInterfaceStyle = mkDefault "Dark";
        AppleKeyboardUIMode = mkDefault 3;
        AppleScrollerPagingBehavior = mkDefault true;
        AppleShowAllExtensions = mkDefault true;
        AppleShowScrollBars = mkDefault "Automatic";

        NSAutomaticCapitalizationEnabled = mkDefault false;
        NSAutomaticDashSubstitutionEnabled = mkDefault false;
        NSAutomaticPeriodSubstitutionEnabled = mkDefault false;
        NSAutomaticQuoteSubstitutionEnabled = mkDefault false;
        NSAutomaticSpellingCorrectionEnabled = mkDefault false;

        NSDocumentSaveNewDocumentsToCloud = mkDefault false;
        NSNavPanelExpandedStateForSaveMode = mkDefault true;
        NSNavPanelExpandedStateForSaveMode2 = mkDefault true;

        NSTableViewDefaultSizeMode = mkDefault 1;
        NSUseAnimatedFocusRing = mkDefault false;
        NSWindowResizeTime = mkDefault 0.1;

        "com.apple.keyboard.fnState" = mkDefault true;
        "com.apple.mouse.tapBehavior" = mkDefault 1;
        "com.apple.sound.beep.feedback" = mkDefault 0;
        "com.apple.sound.beep.volume" = mkDefault 0.5;
        # TODO: Use Mos (Homebrew) or similar to reverse for mouse
        "com.apple.swipescrolldirection" = mkDefault true;
        "com.apple.springing.delay" = mkDefault 0.2;
        "com.apple.trackpad.scaling" = mkDefault 3.0;
        "com.apple.trackpad.trackpadCornerClickBehavior" = mkDefault 1;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = mkDefault false;

      dock = {
        enable-spring-load-actions-on-all-items = mkDefault true;
        expose-group-by-app = mkDefault true;
        magnification = mkDefault false;
        mineffect = mkDefault "scale";
        minimize-to-application = mkDefault true;
        orientation = mkDefault "left";
        show-process-indicators = mkDefault true;
        tilesize = mkDefault 32;

        # TODO: Check back later
        wvous-tl-corner = mkDefault 1;
        wvous-br-corner = mkDefault 1;
        wvous-tr-corner = mkDefault 1;
        wvous-bl-corner = mkDefault 1;
      };

      finder = {
        AppleShowAllFiles = mkDefault true;
        FXDefaultSearchScope = mkDefault "SCcf"; # Current folder
        FXEnableExtensionChangeWarning = mkDefault false;
        FXPreferredViewStyle = mkDefault "Nlsv"; # List view
        ShowPathbar = mkDefault true;
      };

      menuExtraClock. ShowDate = mkDefault 0;

      smb.NetBIOSName = mkDefault hostname;

      trackpad = {
        Clicking = mkDefault true;
        TrackpadRightClick = mkDefault true;
      };

      universalaccess = {
        closeViewScrollWheelToggle = mkDefault true;
        closeViewZoomFollowsFocus = mkDefault true;
      };
    };
  };
}

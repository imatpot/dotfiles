_:

{
  system.defaults = {
    ".GlobalPreferences"."com.apple.mouse.scaling" = 10.0;

    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;

      "com.apple.keyboard.fnState" = true;
      "com.apple.trackpad.scaling" = 3.0;

      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.5;
      # TODO: Use Mos (Homebrew) or similar to reverse for mouse
      "com.apple.swipescrolldirection" = true;
      "com.apple.springing.delay" = 0.2;
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };
}

_: {
  imports = [
    ../../modules/darwin/accessibility.nix
    ../../modules/darwin/finder.nix
    ../../modules/darwin/peripherals.nix
    ../../modules/darwin/ui.nix
  ];

  # TODO: Maybe don't commit contact details to git
  # macos.system.defaults.loginwindow.LoginwindowText = "<contact info>";

  networking.computerName = "McDonald's";

  # TODO: These services look neat: skhd, spacebar/sketchybar, yabai
}

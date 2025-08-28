{inputs, ...}: {
  imports = [
    "${inputs.self}/modules/darwin/accessibility.nix"
    "${inputs.self}/modules/darwin/finder.nix"
    "${inputs.self}/modules/darwin/peripherals.nix"
    "${inputs.self}/modules/darwin/ui.nix"
  ];

  # TODO: Maybe don't commit contact details to git
  # macos.system.defaults.loginwindow.LoginwindowText = "<contact info>";

  networking.computerName = "McDonald's";

  # TODO: These services look neat: skhd, spacebar/sketchybar, yabai
}

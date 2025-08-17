{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.flutter.enable =
      outputs.lib.mkEnableOption "Enable Flutter toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.flutter.enable {
    modules.users.dev.adb.enable = true;

    home.packages = with pkgs; [
      master.fvm
      master.fastlane
    ];
  };
}

{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.adb.enable =
      outputs.lib.mkEnableOption "Enable ADB tools";
  };

  config = outputs.lib.mkIf config.modules.users.dev.adb.enable {
    home.packages = with pkgs; [ android-tools scrcpy ];
  };
}

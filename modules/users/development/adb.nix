{
  outputs,
  config,
  pkgs,
  ...
}: let
  adbitch = pkgs.writeShellScriptBin "adbitch" ''
    if [ -z "$1" ]; then echo "Usage: adbitch <ip>"; exit 1; fi
    echo "Connecting to $1..."
    adb connect $1:$(${pkgs.nmap}/bin/nmap $1 -p 30000-49999 | ${pkgs.gawk}/bin/awk "/\/tcp/" | cut -d/ -f1)
  '';
in {
  options = {
    modules.users.dev.adb.enable = outputs.lib.mkEnableOption "Enable ADB tools";
  };

  config = outputs.lib.mkIf config.modules.users.dev.adb.enable {
    home.packages = with pkgs; [
      android-tools
      master.scrcpy
      adbitch
    ];
  };
}

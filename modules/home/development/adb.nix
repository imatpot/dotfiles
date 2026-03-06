{
  outputs,
  config,
  pkgs,
  system,
  hostname,
  ...
}: let
  adbitch = pkgs.writeShellScriptBin "adbitch" ''
    if [ -z "$1" ]; then echo "Usage: adbitch <ip>"; exit 1; fi
    echo "Connecting to $1..."
    adb connect $1:$(${pkgs.nmap}/bin/nmap $1 -p 30000-49999 | ${pkgs.gawk}/bin/awk "/\/tcp/" | cut -d/ -f1)
  '';
in
  outputs.lib.mkConfigModule config true "dev.adb"
  <| outputs.lib.mkFor system hostname
  {
    common.home.packages = with pkgs; [
      android-tools
      scrcpy
      adbitch
    ];
    
    systems.linux.home.packages = with pkgs; [
      qtscrcpy
    ];
  }

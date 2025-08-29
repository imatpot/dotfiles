{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.flutter"
{
  modules.dev.adb.enable = true;

  home.packages = with pkgs; [
    master.fvm
    master.fastlane
  ];
}

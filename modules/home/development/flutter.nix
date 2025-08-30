{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.flutter"
{
  modules.dev.adb.enable = true;

  home.packages = with pkgs; [
    master.fvm
    master.fastlane
  ];
}

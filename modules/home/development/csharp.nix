{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.csharp" {
  home.packages = with pkgs; [
    (
      with unstable.dotnetCorePackages;
        combinePackages [
          # sdk_6_0
          # sdk_7_0
          sdk_8_0
        ]
    )
  ];
}

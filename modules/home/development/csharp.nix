{
  outputs,
  config,
  pkgs,
  ...
}: {
  options = {
    modules.users.dev.csharp.enable = outputs.lib.mkEnableOption "Enable C# toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.csharp.enable {
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
  };
}

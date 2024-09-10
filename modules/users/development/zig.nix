{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.zig.enable =
      outputs.lib.mkEnableOption "Enable Zig toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.zig.enable {
    home.packages = with pkgs; [ unstable.zig ];
  };
}

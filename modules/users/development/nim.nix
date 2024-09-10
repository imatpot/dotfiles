{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.nim.enable =
      outputs.lib.mkEnableOption "Enable Nim toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.nim.enable {
    home.packages = with pkgs; [ unstable.nim ];
  };
}

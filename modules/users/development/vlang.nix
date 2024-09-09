{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.vlang.enable =
      outputs.lib.mkEnableOption "Enable V toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.vlang.enable {
    home.packages = with pkgs.unstable; [ vlang ];
  };
}

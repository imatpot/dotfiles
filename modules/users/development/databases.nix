{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.databases.enable =
      outputs.lib.mkEnableOption "Enable database tools";
  };

  config = outputs.lib.mkIf config.modules.users.dev.databases.enable {
    home.packages = with pkgs.unstable; [ postgresql sqlite ];
  };
}

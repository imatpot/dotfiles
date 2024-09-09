{ outputs, config, ... }:

{
  options = {
    modules.users.wayland.enable = outputs.lib.mkEnableOption "Enable Wayland";
  };

  config = outputs.lib.mkIf config.modules.users.wayland.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

{
  outputs,
  config,
  pkgs,
  ...
}: let
  waylandVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    GDK_SCALE = "2";
    LIBSEAT_BACKEND = "logind";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
  };
in {
  options = {
    modules.users.wayland.enable = outputs.lib.mkEnableOption "Enable Wayland";
  };

  config = outputs.lib.mkIf config.modules.users.wayland.enable {
    home.packages = with pkgs; [xorg.xeyes];

    # For application launchers. Breaks XServer users on the same system!
    # nixos.environment.sessionVariables = waylandVariables;
    home.sessionVariables = waylandVariables;

    nixos.services.libinput.enable = true;

    # https://discourse.nixos.org/t/home-manager-and-the-mimeapps-list-file-on-plasma-kde-desktops/37694/7
    xdg = {
      configFile."mimeapps.list".enable = false;
      dataFile."applications/mimeapps.list".force = true;
      mimeApps.enable = true;
    };
  };
}

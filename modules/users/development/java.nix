{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.java.enable =
      outputs.lib.mkEnableOption "Enable Java toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.java.enable {
    home.packages = with pkgs.unstable; [ maven ];

    programs.java = {
      enable = true;
      package = pkgs.unstable.jdk21;
    };
  };
}

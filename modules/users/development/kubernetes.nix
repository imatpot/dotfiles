{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.kubernetes.enable =
      outputs.lib.mkEnableOption "Enable Kubernetes tools";
  };

  config = outputs.lib.mkIf config.modules.users.dev.kubernetes.enable {
    home.packages = with pkgs.unstable; [ flux kubectl ];
  };
}

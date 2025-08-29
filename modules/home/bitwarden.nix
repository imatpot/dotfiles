{
  outputs,
  config,
  pkgs,
  ...
}: {
  options = {
    modules.users.bitwarden.enable = outputs.lib.mkEnableOption "Enable Bitwarden";
  };

  config = outputs.lib.mkIf config.modules.users.bitwarden.enable {
    home.packages = with pkgs; [
      bitwarden-cli
      bitwarden-desktop
    ];
  };
}

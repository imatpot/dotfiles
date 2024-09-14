{ inputs, outputs, config, system, ... }:

{
  options = {
    modules.users.zen-browser.enable =
      outputs.lib.mkEnableOption "Enable Zen Browser";
  };

  config = outputs.lib.mkIf config.modules.users.zen-browser.enable {
    home.packages = [ inputs.zen-browser.packages.${system}.specific ];
  };
}

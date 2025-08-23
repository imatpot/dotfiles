{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.neovim.enable = outputs.lib.mkEnableOption "Enable Neovim";
  };

  config = outputs.lib.mkIf config.modules.users.neovim.enable {
    home.packages = with pkgs; [ nixvim ];
  };
}

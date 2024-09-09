{ outputs, config, ... }:

{
  options = {
    modules.users.neovim.enable = outputs.lib.mkEnableOption "Enable Neovim";
  };

  config = outputs.lib.mkIf config.modules.users.neovim.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}

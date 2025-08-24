{
  outputs,
  config,
  ...
}: {
  options = {
    modules.users.ghostty.enable = outputs.lib.mkEnableOption "Enable GhosTTY";
  };

  config = outputs.lib.mkIf config.modules.users.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      installVimSyntax = true;
      installBatSyntax = true;

      settings = {
        background-blur = 20;
        window-padding-x = 6;
        window-padding-y = 6;
        window-inherit-working-directory = false;
      };
    };
  };
}

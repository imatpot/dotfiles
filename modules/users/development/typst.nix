{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.typst.enable =
      outputs.lib.mkEnableOption "Enable Typst toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.typst.enable {
    home.packages = with pkgs; [
      unstable.typst
      pandoc
      texliveSmall
      poppler_utils
    ];
  };
}

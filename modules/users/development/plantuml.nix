{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.plantuml.enable =
      outputs.lib.mkEnableOption "Enable PlantUML toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.plantuml.enable {
    home.packages = with pkgs; [ plantuml graphviz ];
  };
}

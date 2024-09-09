{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.javascript.enable =
      outputs.lib.mkEnableOption "Enable JavaScript/TypeScript toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.javascript.enable {
    home.packages = with pkgs.unstable; [ deno nodejs ];
  };
}

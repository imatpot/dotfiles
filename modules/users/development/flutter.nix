{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.flutter.enable =
      outputs.lib.mkEnableOption "Enable Flutter toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.flutter.enable {
    modules.users.dev.adb.enable = true;

    # Once https://github.com/leoafarias/fvm/pull/775 is merged, everything
    # here could be replaced with a "lean" FVM installation.

    home.packages = with pkgs.unstable; [ flutter ];
    programs = let
      extra = ''
        # Add FVM to PATH
        export PATH="$HOME/.fvm_flutter/bin:$PATH"
      '';
    in {
      bash.initExtra = extra;
      zsh.initExtra = extra;
    };
  };
}

{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.python.enable =
      outputs.lib.mkEnableOption "Enable Python toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.python.enable {
    home = {
      packages = with pkgs;
        [
          (unstable.python3.withPackages
            (pythonPkgs: with pythonPkgs; [ pip ipykernel ]))
        ];

      shellAliases = rec {
        python = "python3";
        py = python;
      };
    };
  };
}

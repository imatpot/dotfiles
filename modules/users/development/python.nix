{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.python.enable =
      outputs.lib.mkEnableOption "Enable Python toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.python.enable {
    home = {
      packages = with pkgs.unstable;
        [
          (python3.withPackages
            (pyPkgs: with pyPkgs; [ pip ipykernel jupyter ]))
        ];

      shellAliases = rec {
        python = "python3";
        py = python;
        venv = "source .venv/bin/activate";
        new-venv = "python -m venv .venv";
        venv-new = new-venv;
      };
    };
  };
}

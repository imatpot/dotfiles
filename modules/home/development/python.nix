{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.python"
{
  home = {
    packages = with pkgs; [
      (unstable.python3.withPackages (
        pythonPkgs:
          with pythonPkgs; [
            pip
            ipykernel
          ]
      ))
    ];

    shellAliases = rec {
      python = "python3";
      py = python;
    };
  };
}

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.python"
{
  home = {
    packages = with pkgs; [
      mamba-cpp
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

    sessionVariables = {
      MAMBA_ROOT_PREFIX = config.home.homeDirectory + "/.mamba";
    };
  };
}

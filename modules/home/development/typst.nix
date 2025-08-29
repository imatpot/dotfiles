{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.typst"
{
  home.packages = with pkgs; [
    unstable.typst
    pandoc
    texliveSmall
    poppler_utils
  ];
}

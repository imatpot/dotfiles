{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.typst"
{
  home.packages = with pkgs; [
    unstable.typst
    typstyle
    prettypst
    tinymist
    pandoc
    texliveSmall
    poppler_utils
  ];
}

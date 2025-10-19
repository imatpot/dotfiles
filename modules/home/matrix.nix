{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "matrix"
{
  programs.element-desktop = {
    enable = true;
  };
}

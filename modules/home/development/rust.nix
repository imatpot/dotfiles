{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.rust"
{
  home.packages = with pkgs; [
    cargo
    rustc
  ];
}

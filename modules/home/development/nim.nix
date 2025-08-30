{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.nim" {
  home.packages = with pkgs; [
    unstable.nim
  ];
}

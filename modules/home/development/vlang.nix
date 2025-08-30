{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.vlang" {
  home.packages = with pkgs; [unstable.vlang];
}

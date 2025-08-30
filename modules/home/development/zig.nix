{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.zig" {
  home.packages = with pkgs; [unstable.zig];
}

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.go" {
  home.packages = with pkgs; [
    go
    gopls
  ];
}

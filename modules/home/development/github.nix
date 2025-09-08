{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "dev.github" {
  home.packages = with pkgs; [
    gh
  ];
}

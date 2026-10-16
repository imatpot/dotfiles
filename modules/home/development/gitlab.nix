{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "dev.gitlab" {
  home.packages = with pkgs; [
    glab
  ];
}

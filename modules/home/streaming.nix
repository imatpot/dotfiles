{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "streaming" {
  home.packages = with pkgs; [
    # stremio # build broken >:(
  ];
}

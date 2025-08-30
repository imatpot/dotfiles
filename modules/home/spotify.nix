{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "spotify" {
  home.packages = with pkgs; [
    spotify
    spicetify-cli
  ];
}

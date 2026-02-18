{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "music" {
  home.packages = with pkgs; [
    spotify
    spicetify-cli
    feishin
  ];
}

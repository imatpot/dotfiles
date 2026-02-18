{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "matrix"
{
  programs.element-desktop = {
    enable = true;
  };

  home.packages = with pkgs; [
    fluffychat
  ];
}

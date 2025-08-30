{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "backblaze"
{
  home.packages = with pkgs; [
    master.backblaze-b2
  ];
}

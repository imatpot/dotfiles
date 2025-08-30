{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.databases"
{
  home.packages = with pkgs; [
    postgresql
    sqlite
  ];
}

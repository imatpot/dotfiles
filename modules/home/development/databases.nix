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
    mariadb.client
    sqlite
    sqlit-tui
  ];
}

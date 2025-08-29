{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.databases"
{
  home.packages = with pkgs; [
    postgresql
    sqlite
  ];
}

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.azure" {
  home.packages = with pkgs; [
    azure-cli
  ];
}

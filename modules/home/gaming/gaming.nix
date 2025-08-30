{
  outputs,
  system,
  hostname,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "gaming" (outputs.lib.mkFor system hostname {
  systems.linux = {
    home.packages = with pkgs; [
      master.r2modman
    ];
  };
})

{
  outputs,
  system,
  hostname,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gaming.enable "gaming.games.pokemmo" (outputs.lib.mkFor system hostname {
  systems.linux = {
    home.packages = with pkgs; [
      pokemmo-installer
    ];
  };
})

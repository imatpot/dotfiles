{
  outputs,
  system,
  hostname,
  config,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gaming.enable "gaming.games.pokemmo" (outputs.lib.mkFor system hostname {
  systems.linux.nixos.services.flatpak = {
    enable = true;
    packages = ["com.pokemmo.PokeMMO"];

    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
})

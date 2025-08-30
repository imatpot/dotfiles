{
  outputs,
  system,
  hostname,
  config,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gaming.enable "gaming.gamemode" (outputs.lib.mkFor system hostname {
  systems.linux = {
    nixos.programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
      };
    };
  };
})

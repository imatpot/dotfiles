{
  outputs,
  system,
  hostname,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "gaming.games.vintage-story" (
  outputs.lib.mkFor system hostname {
    systems.linux.nixos = {
      services.flatpak = {
        enable = true;

        remotes = outputs.lib.mkOptionDefault [
          {
            name = "vintagestory";
            location = "https://flatpak.vintagestory.at/VintageStory.flatpakrepo";
          }
        ];

        packages = [
          {
            appId = "at.vintagestory.VintageStory";
            origin = "vintagestory";
          }
        ];

        update = {
          onActivation = true;
          auto = {
            enable = true;
            onCalendar = "daily";
          };
        };
      };

      networking.firewall = {
        allowedTCPPorts = [42420];
        allowedUDPPorts = [42420];
      };
    };
  }
)

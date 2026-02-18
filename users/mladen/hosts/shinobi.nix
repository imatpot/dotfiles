{
  outputs,
  system,
  hostname,
  ...
}:
outputs.lib.mkFor system hostname {
  hosts.shinobi = {
    modules = {
      gui.enable = true;

      equalizer.enable = true;
      discord.enable = true;
      ghostty.enable = true;
      gnome.enable = true;
      wayland.enable = true;
      zen-browser.enable = true;
      backblaze.enable = true;
      sunshine.enable = true;
      streaming.enable = true;
      music.enable = true;
      virtualisation.enable = true;
      matrix.enable = true;

      stylix.system-wide = true;

      dev = {
        adb.enable = true;
        databases.enable = true;
        flutter.enable = true;
        haskell.enable = true;
        javascript.enable = true;
        plantuml.enable = true;
        python.enable = true;
        rust.enable = true;
        typst.enable = true;
      };

      gaming = {
        enable = true;
        steam.gamescope.enable = false;
      };
    };
  };
}

{ config, ... }:

{
  modules.users = {
    discord.enable = true;
    wayland.enable = true;
    gnome.enable = true;
    zen-browser.enable = true;

    stylix = {
      enable = true;
      system-wide = true;
      theme = "framer";
    };
  };

  # TODO: Autogenerate in default default configs
  nixos.users.users.${config.home.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

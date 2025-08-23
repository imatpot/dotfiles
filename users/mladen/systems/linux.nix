{ config, ... }:

{
  # TODO: Autogenerate in default default configs
  nixos.users.users.${config.home.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}

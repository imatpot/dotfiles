{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;

    autoPrune = {
      enable = true;
      dates = "03:30";
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}

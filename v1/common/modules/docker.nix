{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;

    package = pkgs.unstable.docker;

    autoPrune = {
      enable = true;
      dates = "03:30";
    };
  };

  environment.systemPackages = with pkgs.unstable; [
    docker-compose
  ];
}

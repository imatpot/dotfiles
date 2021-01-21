{ pkgs, ... }:

{
  imports = [
    ./home.nix
  ];

  users.users.mladen = {
    description = "Mladen Brankovic";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "users"
      "docker"
    ];

    isNormalUser = true;
    createHome = true;

    shell = pkgs.fish; # I like fish. Don't judge me.
  };
}

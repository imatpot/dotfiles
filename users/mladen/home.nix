{
  outputs,
  system,
  hostname,
  ...
}:
outputs.lib.mkFor system hostname {
  common = {
    programs.git = {
      userName = "Mladen Branković";
      userEmail = "root@brankovic.dev";
    };

    modules = {
      bitwarden.enable = true;
      stylix.enable = true;
    };
  };

  hosts = {
    shinobi.imports = [./hosts/shinobi.nix];
    mcdonalds.imports = [./hosts/mcdonalds.nix];
    atlas.imports = [./hosts/atlas.nix];
  };
}

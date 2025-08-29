{
  outputs,
  system,
  hostname,
  ...
}:
outputs.lib.mkFor system hostname {
  common = {
    modules.users = {
      neovim.enable = true;
      helix.enable = true;
      zsh.enable = true;
      starship.enable = true;
    };

    programs.git = {
      userName = "Mladen Branković";
      userEmail = "root@brankovic.dev";
    };
  };

  hosts = {
    shinobi.imports = [./hosts/shinobi.nix];
    mcdonalds.imports = [./hosts/mcdonalds.nix];
    atlas.imports = [./hosts/atlas.nix];
  };
}

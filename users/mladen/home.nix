{
  outputs,
  system,
  hostname,
  ...
}:
# TODO: Maybe this split be simplified and moved to default config with concatImports
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

  systems = {
    linux.imports = [./systems/linux.nix];
    darwin.imports = [./systems/darwin.nix];
  };

  hosts = {
    shinobi.imports = [./hosts/shinobi.nix];
    mcdonalds.imports = [./hosts/mcdonalds.nix];
    atlas.imports = [./hosts/atlas.nix];
  };
}

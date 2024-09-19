{ outputs, system, hostname, ... }:

# TODO: Maybe this split be simplified and moved to default config with concatImports

outputs.lib.mkFor system hostname {
  common = {
    # TODO: Move this to lib/users.nix
    imports = outputs.lib.concatImports { path = ../../modules/users; };

    modules.users = {
      neovim.enable = true;
      zsh.enable = true;
      starship.enable = true;

      dev = {
        adb.enable = true;
        databases.enable = true;
        javascript.enable = true;
        plantuml.enable = true;
        python.enable = true;
        rust.enable = true;
        typst.enable = true;
      };
    };

    programs.git = {
      userName = "Mladen Branković";
      userEmail = "root@brankovic.dev";
    };
  };

  systems = {
    linux.imports = [ ./systems/linux.nix ];
    darwin.imports = [ ./systems/darwin.nix ];
  };

  hosts = { mcdonalds.imports = [ ./hosts/mcdonalds.nix ]; };
}

{ config, ... }:

{
  home.shellAliases.nix-rosetta = "nix --system x86_64-darwin";

  # TODO: Autogenerate in default default configs
  macos = {
    users.users.${config.home.username} = {
      createHome = true;
      home = config.home.homeDirectory;
    };

    system.defaults = {
      NSGlobalDomain = { NSDocumentSaveNewDocumentsToCloud = false; };

      dock = {
        orientation = "left";
        tilesize = 32;

        # TODO: Check back later
        wvous-tl-corner = 1;
        wvous-br-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
      };
    };
  };
}

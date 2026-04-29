{lib, ...}: {
  programs.git.settings.user = {
    name = lib.mkDefault "Mladen Branković";
    email = lib.mkDefault "root@brankovic.dev";
  };

  modules = {
    bitwarden.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;

    niri.enable = lib.mkDefault true;
    noctalia.enable = lib.mkDefault true;
  };
}

{lib, ...}: {
  programs.git = {
    userName = lib.mkDefault "Mladen Branković";
    userEmail = lib.mkDefault "root@brankovic.dev";
  };

  modules = {
    bitwarden.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
  };
}

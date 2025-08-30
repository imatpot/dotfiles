{...}: {
  programs.git = {
    userName = "Mladen Branković";
    userEmail = "root@brankovic.dev";
  };

  modules = {
    bitwarden.enable = true;
    stylix.enable = true;
  };
}

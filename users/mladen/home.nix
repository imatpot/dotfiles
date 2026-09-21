{outputs, lib, system, ...}: {
  programs.git.settings.user = {
    name = lib.mkDefault "Mladen Branković";
    email = lib.mkDefault "root@brankovic.dev";
  };

  modules = {
    bitwarden.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;

    niri.enable = lib.mkDefault <| outputs.lib.isLinux system;
    noctalia.enable = lib.mkDefault <| outputs.lib.isLinux system;
  };
}

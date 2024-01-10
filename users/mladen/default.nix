{ ... }:

{
  home-manager.users = {
    mladen.home = {
      inherit stateVersion;
      file."mladen.success".text = "gay";
    };

    # "mladen@nixos".home = {
    #   inherit stateVersion;
    #   file."mladen.nixos.success".text = "";
    # };

    # "mladen@mcdonalds".home = {
    #   inherit stateVersion;
    #   file."mladen.mcdonalds.success".text = "";
    # };
  };
}

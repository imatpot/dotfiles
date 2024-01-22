{ outputs, config, pkgs, ... }:

{
  # Krisp: https://github.com/NixOS/nixpkgs/issues/195512

  home.packages = with pkgs.unstable;
    if (outputs.lib.isWayland config) then [ vesktop ] else [ discord ];

  nixpkgs = {
    overlays = [
      (_: prev: {
        discord = prev.discord.override {
          withOpenASAR = true;
          withVencord = true;
        };
      })
    ];
  };
}

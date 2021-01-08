{
  xsession = {
    enable = true;
    numlock.enable = true;

    inherit (import ./bspwm.nix) windowManager;
  };
}

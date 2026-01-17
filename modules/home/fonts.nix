{
  outputs,
  config,
  system,
  pkgs,
  ...
}: let
  fonts = with pkgs; [
    # Writing
    libertine
    libertinus
    brill
    atkinson-hyperlegible-next
    noto-fonts

    # Coding
    cascadia-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    departure-mono
    nerd-fonts.departure-mono
    cozette
    scientifica
    curie
  ];
in
  outputs.lib.mkConfigModule config config.modules.gui.enable "fonts"
  {
    home.packages = outputs.lib.optionals (outputs.lib.isLinux system) fonts;

    nixos.fonts = {
      packages = fonts;
      fontDir.enable = true;
    };
  }

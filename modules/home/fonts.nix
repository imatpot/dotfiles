{
  outputs,
  config,
  pkgs,
  ...
}: let
  fonts = with pkgs; [
    # Writing
    libertine
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
    home.packages = fonts;

    nixos.fonts = {
      packages = fonts;
      fontDir.enable = true;
    };

    macos.fonts = {
      inherit fonts;
      fontDir.enable = true;
    };
  }

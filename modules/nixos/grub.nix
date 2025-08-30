{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule config config.modules.gui.enable "grub" {
  minegrub.enable = outputs.lib.mkDefaultEnableOption false;
} {
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      gfxmodeEfi = "3440x1440";
      extraConfig = ''
        set gfxpayload=keep
      '';

      minegrub-theme = {
        enable = config.modules.grub.minegrub.enable;
        splash = "Nix isch besser!";
        background = "background_options/1.8  - [Classic Minecraft].png";
        boot-options-count = 3;
      };

      useOSProber = false;
    };
  };
}

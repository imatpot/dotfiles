{...}: {
  modules = {
    gui.enable = true;
    amd.enable = true;
    audio.enable = true;
    camera.enable = true;
    logitech.enable = true;
    linux-zen.enable = true;

    grub.minegrub.enable = true;
    windows = {
      enable = true;
      disk.uuid = "16CB-DB29";
    };
  };
}

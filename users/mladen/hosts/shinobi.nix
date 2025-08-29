{pkgs, ...}: {
  modules = {
    bitwarden.enable = true;
    discord.enable = true;
    ghostty.enable = true;
    gnome.enable = true;
    wayland.enable = true;
    zen-browser.enable = true;

    stylix = {
      enable = true;
      system-wide = true;
    };

    dev = {
      adb.enable = true;
      databases.enable = true;
      flutter.enable = true;
      haskell.enable = true;
      javascript.enable = true;
      plantuml.enable = true;
      python.enable = true;
      rust.enable = true;
      typst.enable = true;
    };

    gaming = {
      enable = true;
      wine.enable = true;
      proton.enable = true;
      steam.enable = true;
      lutris.enable = true;

      games = {
        minecraft.enable = true;
        pokemmo.enable = true;
      };
    };
  };

  services.easyeffects.enable = true;

  # home.file."sops.test.txt".source = config.secrets.backblaze.id.path;

  home.packages = with pkgs; [piper];

  nixos = {
    environment.systemPackages = with pkgs; [lact];

    systemd = {
      packages = with pkgs; [lact];
      services.lactd.wantedBy = ["multi-user.target"];
    };

    hardware = {
      logitech.wireless.enable = true;
      amdgpu = {
        initrd.enable = true;
      };
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services = {
      xserver.videoDrivers = ["modesetting"];
      ratbagd.enable = true;

      sunshine = {
        enable = true;
        autoStart = false;
        capSysAdmin = true;
        openFirewall = true;
      };
    };

    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      initrd.kernelModules = ["amdgpu"];
    };
  };
}

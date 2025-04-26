{ pkgs, ... }:

{
  modules.users = {
    gaming = {
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

  nixos = {
    hardware.logitech.wireless.enable = true;
    services.ratbagd.enable = true;
  };

  home.packages = with pkgs; [piper];
  # home.sessionVariables = {
  #   # "GDK_BACKEND" = "wayland,x11";
  #   # "SDL_VIDEODRIVER" = "wayland,x11";
  #  # "CLUTTER_BACKEND" = "wayland";
  #  # "MOZ_DISABLE_RDD_SANDBOX" = "1";
  #  # "_JAVA_AWT_WM_NONREPARENTING" = "1";
  #  # "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
  #  "QT_QPA_PLATFORM" = "wayland";
  #  "WLR_NO_HARDWARE_CURSORS" = "1";
  #  "__NV_PRIME_RENDER_OFFLOAD" = "1";
  #  "PROTON_ENABLE_NGX_UPDATER" = "1";
  #  "NVD_BACKEND" = "direct";
  #  "__GL_GSYNC_ALLOWED" = "0";
  #  "__GL_VRR_ALLOWED" = "0";
  #  "WLR_EGL_NO_MODIFIERS" = "1";
  #  "WLR_USE_LIBINPUT" = "1";
  #  "__GL_MaxFramesAllowed" = "1";
  #};
  nixos = {
    hardware = {
      amdgpu = {
        initrd.enable = true;
        # amdvlk = {
        #   enable = true;
        #   support32Bit.enable = true;
        # };
      };
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  
    services.xserver.videoDrivers = [ "modesetting" ];
  
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
  
      initrd.kernelModules = [ "amdgpu" ];
      kernel.sysctl = {
        "fs.file-max" = 262144;
      };
    };
  
    security.pam.loginLimits = [
      {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "262144";
      }
      {
        domain = "*";
        item = "memlock";
        type = "-";
        value = "262144";
      }
    ];
    systemd.user.extraConfig = "DefaultLimitNOFILE=262144";
    
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };

  # services.desktopManager.plasma6.enable = true;
  # services.xserver.displayManager.sddm.wayland.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.defaultSession = "plasma";
};
}

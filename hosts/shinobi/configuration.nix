{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";

    gfxmodeEfi = "3440x1440";
    extraConfig = ''
      set gfxpayload=keep
    '';

    minegrub-theme = {
      enable = true;
      splash = "Nix isch besser!";
      background = "background_options/1.8  - [Classic Minecraft].png";
      boot-options-count = 3;
    };

    useOSProber = false;

    # this will add Windows 11 after "NixOS - All configurations" instead of in the middle
    extraInstallCommands = ''
      ${pkgs.coreutils}/bin/cat << EOF >> /boot/grub/grub.cfg

      menuentry "Windows 11" {
        insmod part_gpt
        insmod fat
        search --fs-uuid --no-floppy --set=root 16CB-DB29
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
      EOF
    '';
  };

  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    gedit
    gnome-music
    epiphany
    geary
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-contacts
    gnome-initial-setup
  ];

  programs.dconf.enable = true;
  virtualisation.docker.enable = true;

  virtualisation.oci-containers.backend = "podman";

  environment.systemPackages = with pkgs; [
    firefox
    (vscode.overrideAttrs (self: prev: {
      desktopItems = [
        ((builtins.elemAt prev.desktopItems 0).override {
          startupWMClass = "code-url-handler";
        })
      ];
    }))
    code-cursor
    unstable.backblaze-b2
    obs-studio

    vdhcoapp
    vlc

    gnome-tweaks
    ffmpeg

    spotify
    spicetify-cli
    ungoogled-chromium
    master.r2modman
  ];

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  services.fail2ban = outputs.lib.mkIf config.networking.firewall.enable {
    enable = true;
    ignoreIP = ["10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16"];
    maxretry = 3;
    bantime = "24h";
  };

  networking.firewall.enable = false;

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = ["amdgpu"]; # "nvidia"

  services.flatpak = {
    enable = true;
    packages = ["hu.irl.cameractrls"];

    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
}

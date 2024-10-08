# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stateVersion, hostname, ... }:

{
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # services.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

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

  environment.systemPackages = with pkgs; [
    firefox
    (vscode.overrideAttrs (self: prev: {
      desktopItems = [
        ((builtins.elemAt prev.desktopItems 0).override {
          startupWMClass = "code-url-handler";
        })
      ];
    }))
    backblaze-b2
    obs-studio

    nvtopPackages.full # NVIDIA GPU monitoring tool

    gnome-tweaks
  ];

  # Configure keymap in X11
  # services.xserver = {
  #   layout = "ch";
  #   xkbVariant = "legacy";
  # };

  # Configure console keymap
  # console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # The option definition `sound' in `hosts/shinobi/configuration.nix' no longer has any effect; please remove it.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.mladen = {
  #   isNormalUser = true;
  #   description = "mladen";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   # packages = with pkgs; [
  #   #   firefox
  #   #   vim
  #   #   git
  #   #   #  thunderbird
  #   # ];
  # };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs;
  #   [
  #     #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #     #  wget
  #   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # system.stateVersion = stateVersion; # Did you read the comment?

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}

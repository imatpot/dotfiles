{...}: {
  modules.hosts = {
    btrfs.enable = true;
    nvidia.enable = true;
    fail2ban.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.networkmanager.ensureProfiles.profiles = {
  #   trondheim = {
  #     connection = {
  #       id = "Trondheim";
  #       type = "wifi";
  #     };
  #
  #     wifi = {
  #       ssid = "Trondheim";
  #       mode = "infrastructure";
  #     };
  #
  #     wifi-security = {
  #       auth-alg = "open";
  #       key-mgmt = "wpa-psk";
  #       psk = "<password>"; # TODO: use secrets
  #     };
  #
  #     ipv4.mode = "auto";
  #     ipv6.mode = "auto";
  #   };
  # };

  services.openssh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}

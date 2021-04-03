{ config, ... }:

{
  # Not yet installed automatically in NixOS v20.09 (Nightingale)
  # https://github.com/NixOS/nixpkgs/pull/85464
  environment.systemPackages = [ config.services.samba.package ];

  services.samba = {
    enable = true;
    enableNmbd = true;

    # $ sudo smbpasswd -a yourusername
    syncPasswordsByPam = true;

    # This adds to the [global] section
    extraConfig = ''
      server string = NixOS SMB
      server role = standalone server
    '';

    shares = {
      share = {
        path = "/mnt/share";
        public = "no";
        writable = "yes";
        browseable = "yes";
      };
    };
  };
}

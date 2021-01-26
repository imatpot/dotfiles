{ config, ... }:

{
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
      smb = {
        path = "/mnt/smb";
        public = "no";
        writable = "yes";
        browseable = "yes";
      };
    };
  };
}

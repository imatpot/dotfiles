{ config, ... }:

# $ sudo smbpasswd -a yourusername

{  services.samba = {
    enable = true;
    enableNmbd = true;


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

{
  outputs,
  config,
  pkgs,
  system,
  hostname,
  username,
  ...
}:
outputs.lib.mkConfigModule config false "samba" (
  outputs.lib.mkFor system hostname {
    systems.linux.nixos = {
      services = {
        samba = {
          enable = true;
          openFirewall = true;

          nmbd.enable = false;
          winbindd.enable = false;

          settings = {
            global = {
              workgroup = "WORKGROUP";
              security = "user";
              "map to guest" = "Never";
            };

            ${username} = {
              path = config.home.homeDirectory;
              browseable = "yes";
              "read only" = "no";
              "guest ok" = "no";
              "valid users" = username;
              "force user" = username;
              "create mask" = "0644";
              "directory mask" = "0755";
            };
          };
        };

        samba-wsdd = {
          enable = true;
          openFirewall = true;
        };

        avahi = {
          enable = true;
          openFirewall = true;
          nssmdns4 = true;
          publish = {
            enable = true;
            addresses = true;
          };
        };
      };

      system.activationScripts.sambaUsers.text =
        # bash
        ''
          if ! ${outputs.lib.getExe' pkgs.samba "pdbedit"} -L | ${outputs.lib.getExe' pkgs.gawk "awk"} -F: '$1 == "${username}" {found=1; exit} END {exit !found}'; then
            (echo "changeme"; echo "changeme") | ${outputs.lib.getExe' pkgs.samba "smbpasswd"} -s -a ${username}
          fi
        '';
    };
  }
)

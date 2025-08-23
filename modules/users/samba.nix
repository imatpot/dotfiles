{
  outputs,
  config,
  system,
  hostname,
  username,
  ...
}: {
  options = {
    modules.users.samba.enable = outputs.lib.mkEnableOption "Enable SMB share in home directory";
  };

  config = outputs.lib.mkIf config.modules.users.samba.enable (outputs.lib.mkFor system hostname {
    systems.linux = {
      nixos.services.samba = {
        enable = true;
        enableNmbd = false;
        enableWinbindd = false;
        extraConfig = ''
          guest account = ${username}
          map to guest = Bad User

          load printers = no
          printcap name = /dev/null

          log file = /var/log/samba/client.%I
          log level = 2
        '';

        shares = {
          "${config.home.homeDirectory}" = {
            "path" = config.home.homeDirectory;
            "guest ok" = "yes";
            "read only" = "no";
          };
        };
      };
    };
  });
}

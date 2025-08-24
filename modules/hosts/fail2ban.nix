{
  outputs,
  config,
  ...
}: {
  options = {
    modules.hosts.fail2ban.enable = outputs.lib.mkEnableOption "Enable fail2ban";
  };

  config = outputs.lib.mkIf config.modules.hosts.fail2ban.enable {
    services.fail2ban = outputs.lib.mkIf config.networking.firewall.enable {
      enable = true;
      ignoreIP = ["10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16"];
      maxretry = 3;
      bantime = "24h";
    };
  };
}

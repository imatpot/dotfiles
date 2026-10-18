{
  outputs,
  system,
  hostname,
  config,
  username,
  ...
}:
outputs.lib.mkConfigModule config true "virtualisation"
<| outputs.lib.mkFor system hostname
{
  systems.linux = {
    nixos = {
      modules.virtualisation.enable = true;
      users.users.${username} = {
        autoSubUidGidRange = true;
        # subUidRanges = [{ startUid = 100000; count = 65536; }];
        # subGidRanges = [{ startGid = 100000; count = 65536; }];
        # extraGroups = ["podman"];
      };
    };

    services.podman = {
      enable = true;
      enableTypeChecks = true;
    };
  };
}

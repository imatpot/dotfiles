{
  outputs,
  config,
  ...
}: {
  options = {
    modules.hosts.btrfs.enable = outputs.lib.mkEnableOption "Enable BTRFS";
  };

  config = outputs.lib.mkIf config.modules.hosts.btrfs.enable {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
  };
}

{outputs, ...}: {
  options = {
    modules.hosts.btrfs.enable = outputs.lib.mkEnableOption "Enable BTRFS";
  };

  config = {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
  };
}

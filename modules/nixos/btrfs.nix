{
  outputs,
  config,
  ...
}:
outputs.lib.mkModule' config false "btrfs" {
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = ["/"];
  };
}

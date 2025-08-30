{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "btrfs" {
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = ["/"];
  };
}

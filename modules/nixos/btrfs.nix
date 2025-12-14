{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "btrfs" {
  services.btrfs.autoScrub = {
    enable = true;
    interval = "Mon *-*-* 03:00:00 UTC";
    fileSystems = ["/"];
  };
}

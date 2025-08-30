{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "linux-zen" {
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
}

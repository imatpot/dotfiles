{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "nvidia"
{
  hardware = {
    graphics.enable = true;
    nvidia.open = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];
}

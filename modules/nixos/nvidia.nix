{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "nvidia"
{
  hardware = {
    nvidia.open = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];
}

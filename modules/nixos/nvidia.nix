{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "nvidia"
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

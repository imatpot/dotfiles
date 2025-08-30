{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "amd"
{
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu" "modesetting"];

  hardware = {
    amdgpu.initrd.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}

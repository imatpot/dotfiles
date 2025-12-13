{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "amd"
{
  boot.initrd.kernelModules = ["amdgpu"];

  services = {
    xserver.videoDrivers = ["amdgpu" "modesetting"];
    lact.enable = true;
  };

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
        hipcc
        rccl
        miopen
        miopen-hip
        rocminfo
        rocm-smi
        rocm-runtime
        rocm-device-libs
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  environment.variables = {
    PYTORCH_ROCM_ARCH = "gfx1030";
    HSA_OVERRIDE_GFX_VERSION = "10.3.0y";
    ROCM_PATH = "/opt/rocm";
    HIP_VISIBLE_DEVICES = "0";
  };

  environment.systemPackages = with pkgs.rocmPackages; [
    rocblas
    hipblas
    clr
    hipcc
    rccl
    miopen
    miopen-hip
    rocminfo
    rocm-smi
    rocm-runtime
    rocm-device-libs
  ];
}

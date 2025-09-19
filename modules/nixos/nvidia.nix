{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule config false "nvidia"
{
  cuda.enable = outputs.lib.mkDefaultEnableOption config.modules.nvidia.enable;
}
{
  nixpkgs.config.cudaSupport = config.modules.nvidia.cuda.enable;
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs;
        outputs.lib.optionals config.modules.nvidia.cuda.enable [
          cudaPackages.cudatoolkit
          cudaPackages.nccl

          # NOTE: conflicting subpaths on 2025-09-01
          (cudaPackages.cudnn.overrideAttrs (prev: {
            postInstall =
              (prev.postInstall or "")
              + ''
                rm $out/LICENSE
              '';
          }))
        ];
    };

    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      nvidiaSettings = true;
      modesetting.enable = true;

      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };

    nvidia-container-toolkit.enable = true;
  };

  virtualisation = {
    docker.enableNvidia = true;
    podman.enableNvidia = true;
  };

  environment.systemPackages = with pkgs;
    [
      nvtopPackages.full
    ]
    ++ outputs.lib.optionals config.modules.nvidia.cuda.enable [
      cudaPackages.cudatoolkit
    ];
}

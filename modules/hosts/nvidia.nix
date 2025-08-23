{
  outputs,
  pkgs,
  ...
}: {
  options = {
    modules.hosts.nvidia.enable = outputs.lib.mkEnableOption "Enable NVIDIA drivers & tools";
  };

  config = {
    hardware = {
      graphics.enable = true;

      nvidia = {
        open = true;

        powerManagement = {
          enable = true;
          finegrained = true;
        };
      };
    };

    services.xserver.videoDrivers = ["nvidia"];

    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
}

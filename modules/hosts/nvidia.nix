{
  outputs,
  config,
  pkgs,
  ...
}: {
  options = {
    modules.hosts.nvidia.enable = outputs.lib.mkEnableOption "Enable NVIDIA drivers & tools";
  };

  config = outputs.lib.mkIf config.modules.hosts.nvidia.enable {
    hardware = {
      graphics.enable = true;
      nvidia.open = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
}

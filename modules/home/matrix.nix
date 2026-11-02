{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "matrix"
{
  programs.element-desktop = {
    enable = true;
  };

  nixos.services.flatpak = {
    enable = true;
    packages = [
      "in.cinny.Cinny"
      "moe.sable.client"
    ];

    update = outputs.lib.mkDefault {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
}

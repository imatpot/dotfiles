{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "matrix"
{
  programs.element-desktop = {
    enable = true;
  };

  home.packages = with pkgs; [
    sable-next
  ];

  nixos.services.flatpak = {
    enable = true;
    packages = ["in.cinny.Cinny"];

    update = outputs.lib.mkDefault {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
}

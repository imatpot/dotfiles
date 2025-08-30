{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "camera" {
  services.flatpak = {
    enable = true;
    packages = ["hu.irl.cameractrls"];

    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
}

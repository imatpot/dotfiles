{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config true "ssh"
{
  nixos.services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
}

{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config true "ssh"
{
  nixos.services.openssh.enable = true;

  programs.ssh = {
    enable = true;
  };
}

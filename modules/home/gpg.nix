{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config true "gpg"
{
  nixos.programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.gpg = {
    enable = true;
  };
}

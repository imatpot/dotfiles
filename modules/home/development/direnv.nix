{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config true "dev.direnv"
{
  programs.direnv = {
    enable = true;
    silent = true;

    nix-direnv.enable = true;
  };
}

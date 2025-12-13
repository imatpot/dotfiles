{
  outputs,
  pkgs,
  config,
  ...
}:
outputs.lib.mkConfigModule config true "sops"
{
  home.packages = with pkgs; [sops];
  sops.age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/aegis"];
  nixos.sops.age.sshKeyPaths = ["/etc/ssh/aegis"];
}

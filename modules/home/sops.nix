{
  outputs,
  pkgs,
  config,
  ...
}:
outputs.lib.mkModule' config true "sops"
{
  home.packages = with pkgs; [sops];
  sops.age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/aegis"];
}

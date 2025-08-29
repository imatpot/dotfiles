{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.vlang" {
  home.packages = with pkgs; [unstable.vlang];
}

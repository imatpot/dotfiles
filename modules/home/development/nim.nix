{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.nim" {
  home.packages = with pkgs; [
    unstable.nim
  ];
}

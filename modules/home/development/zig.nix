{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.zig" {
  home.packages = with pkgs; [unstable.zig];
}

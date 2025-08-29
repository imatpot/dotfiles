{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.rust"
{
  home.packages = with pkgs; [
    cargo
    rustc
  ];
}

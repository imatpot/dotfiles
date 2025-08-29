{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.kubernetes" {
  home.packages = with pkgs; [
    flux
    kubectl
  ];
}

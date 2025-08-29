{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.plantuml" {
  home.packages = with pkgs; [
    plantuml
    graphviz
  ];
}

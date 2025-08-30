{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.plantuml" {
  home.packages = with pkgs; [
    plantuml
    graphviz
  ];
}

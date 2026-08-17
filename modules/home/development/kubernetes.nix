{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.kubernetes" {
  home.packages = with pkgs; [
    kubectl
    kubetui
    k9s
    kubernetes-helm
  ];
}

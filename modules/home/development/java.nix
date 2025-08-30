{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.java" {
  home.packages = with pkgs; [unstable.maven];

  programs.java = {
    enable = true;
    package = pkgs.unstable.jdk21;
  };
}

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule config false "dev.java"
{
  jdk = outputs.lib.mkDefaultEnableOption pkgs.unstable.jdk21;
}
{
  home.packages = with pkgs; [unstable.maven];

  programs.java = {
    enable = true;
    package = config.modules.dev.java.jdk;
  };
}

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.java" {
  home.packages = with pkgs; [unstable.maven];

  programs.java = {
    enable = true;
    package = pkgs.unstable.jdk21;
  };
}

{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.unstable.jdk21;
  };
}

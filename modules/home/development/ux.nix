{pkgs, ...}: {
  home.packages = with pkgs; [
    watchexec
    just
  ];
}

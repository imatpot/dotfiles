{ hostname, ... }:

{
  system.programs.zsh.enable = hostname == "shinobi";
  home.file."debug.info".text = "zsh";
}

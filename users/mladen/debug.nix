{ pkgs, username, ... }:

{
  system.users.users.${username}.packages = [ pkgs.neofetch ];

  home.file."debug.info".text = "zsh";
}

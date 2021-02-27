{ pkgs }:

{
  starship = {
    enable = true;
    package = pkgs.unstable.starship;

    settings = {
      character = {
        success_symbol = "»";
        error_symbol = "»";
      };

      directory = {
        truncation_length = 6;
        style = "bold yellow";
        read_only = ":ro";
      };

      git_branch = {
        style = "bold blue";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        modified = "*";
        untracked = "!";
        deleted = "-";
        diverged = "⇄";
        ahead = "˄";
        behind = "˅";
        style = "bold purple";
      };

      nix_shell = {
        format = "in [$symbol$state( $name)]($style) ";
      };
    };
  };
}

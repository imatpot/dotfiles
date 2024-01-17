{ ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      character = {
        error_symbol = "»";
        success_symbol = "»";
      };

      directory = {
        read_only = ":ro";
        read_only_style = "bold red";
        style = "bold yellow";
        truncation_length = 0;
      };

      docker_context = { disabled = true; };

      gcloud = { disabled = true; };

      git_branch = {
        format = "[$symbol$branch]($style) ";
        style = "bold blue";
        symbol = "git:";
      };

      git_status = {
        ahead = "↑";
        behind = "↓";
        conflicted = "ϟ";
        deleted = "×";
        diverged = "↕";
        format = "([\\($all_status$ahead_behind\\)]($style) )";
        # format = "in [$symbol$state($name)]($style) ";
        modified = "*";
        renamed = ">";
        staged = "+";
        stashed = "S";
        style = "bold purple";
        untracked = ":";
        up_to_date = "";
      };

      nix_shell = {
        format = "in [nix(:$name)](bold cyan) [\\($state\\)](bold purple) ";
      };
    };
  };
}

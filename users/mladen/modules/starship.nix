{
  starship = {
    enable = true;

    settings =  {
      character = {
        symbol = "»";
      };

      directory = {
        truncation_length = 6;
        style = "bold yellow";
        read_only = ":ro";
      };

      git_branch = {
        format = " [$symbol$branch]($style) ";
        style = "bold blue";
      };

      git_status = {
        modified = "*";
        untracked = "!";
        deleted = "×";
        style = "bold purple";
      };
    };
  };
}

{
  fish = {
    enable = true;

    shellAliases = {
      # Use proper sudo wrapper in nix-shell
      "sudo" = "/run/wrappers/bin/sudo";

      "ll" = "ls -la --group-directories-first";
      "cd.." = "cd ..";

      "fuck" = "thefuck";
      "please" = "thefuck";
    };

    shellAbbrs = {
      "frc" = "code ~/.config/fish/config.fish";
      "sfrc" = "source ~/.config/fish/config.fish";

      "nix-generations" = "nix-env -p /nix/var/nix/profiles/system --list-generations";
      "nixg" = "nix-env -p /nix/var/nix/profiles/system --list-generations";
      "nxg" = "nix-env -p /nix/var/nix/profiles/system --list-generations";

      "nxrs" = "sudo nixos-rebuild switch";
      "nixrs" = "sudo nixos-rebuild switch";
      "nxrs-r" = "sudo nixos-rebuild switch && reboot";
      "nixrs-r" = "sudo nixos-rebuild switch && reboot";

      "clb" = "git branch --merged | grep -v \* | xargs git branch -D";

      "py" = "python3";
      "pip" = "pip3";

      "pub" = "flutter pub";
      "br" = "flutter pub run build_runner --delete-conflicting-outputs";
    };

    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      gitp = ''
        if [ $argv[1] = "ush" ]
            git push $argv[2..-1]
        else if [ $argv[1] = "ull" ]
            git pull $argv[2..-1]
        else
            echo "r/ihadastroke"
        end
      '';
    };

    # TODO: Only add Starship when module is active
    loginShellInit = ''
      #
      # COLOR THEME
      #

      set nord0 2e3440
      set nord1 3b4252
      set nord2 434c5e
      set nord3 4c566a
      set nord4 d8dee9
      set nord5 e5e9f0
      set nord6 eceff4
      set nord7 8fbcbb
      set nord8 88c0d0
      set nord9 81a1c1
      set nord10 5e81ac
      set nord11 bf616a
      set nord12 d08770
      set nord13 ebcb8b
      set nord14 a3be8c
      set nord15 b48ead

      set fish_color_normal $nord4
      set fish_color_command $nord9
      set fish_color_quote $nord14
      set fish_color_redirection $nord9
      set fish_color_end $nord6
      set fish_color_error $nord11
      set fish_color_param $nord4
      set fish_color_comment $nord3
      set fish_color_match $nord8
      set fish_color_search_match $nord8
      set fish_color_operator $nord9
      set fish_color_escape $nord13
      set fish_color_cwd $nord8
      set fish_color_autosuggestion $nord3
      set fish_color_user $nord4
      set fish_color_host $nord9
      set fish_color_cancel $nord15
      set fish_pager_color_prefix $nord13
      set fish_pager_color_completion $nord3
      set fish_pager_color_description $nord10
      set fish_pager_color_progress $nord12
      set fish_pager_color_secondary $nord1

      #
      # START STARSHIP
      #

      starship init fish | source
    '';
  };
}

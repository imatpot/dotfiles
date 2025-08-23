{ config, outputs, pkgs, ... }:

let
  extra = ''
    ssh-add ~/.ssh/aegissh &> /dev/null
    ssh-add ~/.ssh/mladen.brankovic.at.golog.ch &> /dev/null
    ssh-add ~/.ssh/mladen.brankovic.at.students.fhnw.ch &> /dev/null

    export DIRENV_LOG_FORMAT=""
    eval "$(${pkgs.direnv}/bin/direnv hook zsh)"

    alias nixvim="nix run path:/Users/mladen/Developer/life/nixvim --"
    alias nv="nixvim"

    export PATH="$PATH:${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/share/npm/bin:/opt/homebrew/bin"
  '';

in {
  modules.users = {
    dev = {
      adb.enable = true;
      csharp.enable = true;
      databases.enable = true;
      flutter.enable = true;
      haskell.enable = true;
      javascript.enable = true;
      kubernetes.enable = true;
      plantuml.enable = true;
      python.enable = true;
      rust.enable = true;
      typst.enable = true;
    };
  };

  home.packages = with pkgs; [
    direnv
    backblaze-b2
  ];

  programs = {
    bash.initExtra = extra;
    zsh.initContent = extra;

    git = {
      userName = outputs.lib.mkForce "Mladen Branković";
      userEmail = outputs.lib.mkForce "mladen.brankovic@golog.ch";
      signing = outputs.lib.mkForce {
        key = "588B95BE8E35DD34";
        signByDefault = true;
      };
    };

    ssh.extraConfig = ''
      Host gitlab.com
        Hostname altssh.gitlab.com
        Port 443
    '';
  };
}

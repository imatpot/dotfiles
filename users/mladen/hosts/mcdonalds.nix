{ outputs, pkgs, ... }:

let
  extra = ''
    ssh-add ~/.ssh/aegissh &> /dev/null
    ssh-add ~/.ssh/mladen.brankovic.at.golog.ch &> /dev/null
    ssh-add ~/.ssh/mladen.brankovic.at.students.fhnw.ch &> /dev/null

    export DIRENV_LOG_FORMAT=""
    eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
  '';

in {
  modules.users = {
    dev = {
      csharp.enable = true;
      java.enable = true;
      kubernetes.enable = true;
      flutter.enable = true;
      helix.enable = true;
    };
  };

  home.packages = [ pkgs.direnv ];

  programs = {
    bash.initExtra = extra;
    zsh.initExtra = extra;

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

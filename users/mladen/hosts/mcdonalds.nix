{ outputs, ... }:

{
  programs = {
    zsh.initExtra = ''
      ssh-add ~/.ssh/mladen.brankovic.at.golog.ch &> /dev/null
      ssh-add ~/.ssh/mladen.brankovic.at.students.fhnw.ch &> /dev/null
    '';

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

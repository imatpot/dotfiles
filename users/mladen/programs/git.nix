{
  git = {
    enable = true;

    userName = "Mladen Brankovic";
    userEmail = "root@brankovic.dev";

    aliases = {
      purge = "!git reset --hard && git clean -df";
      amend = "commit -a --amend";
      uncommit = "reset HEAD^1 --mixed";
      unadd = "reset";
    };

    signing = {
      key = "461A12F441E8667E";
      signByDefault = true;
    };
  };
}

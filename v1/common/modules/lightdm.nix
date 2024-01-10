{
  displayManager = {
    defaultSession = "gnome";

    lightdm = {
      enable = true;

      greeters.tiny = {
        enable = false;

        label = {
          user = "username";
          pass = "password";
        };

        extraConfig = ""; # TODO: Make Tiny prettier
      };
    };
  };
}

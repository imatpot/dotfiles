{pkgs, ...}: {
  picom = {
    enable = true;

    # Round corner support -- https://github.com/ibhagwan/picom
    package = pkgs.nur.repos.reedrw.picom-next-ibhagwan;
    experimentalBackends = true;

    blur = true;

    extraOptions = ''
      round-borders = 1;
      corner-radius = 15.0;
    '';
  };
}

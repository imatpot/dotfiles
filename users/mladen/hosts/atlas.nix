{...}: {
  modules.users = {
    samba.enable = true;

    stylix = {
      enable = true;
      system-wide = true;
    };
  };
}

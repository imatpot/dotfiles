{ outputs, username, system, hostname, stateVersion, osConfig, ... }:

with outputs.lib;

mkFor system hostname {
  common = {
    programs = {
      # enable only on non-NixOS systems, also see lib/users.nix
      # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L18
      home-manager.enable = mkDefault (osConfig == null);

      vim.enable = mkDefault true;
      git.enable = mkDefault true;
      ssh.enable = mkDefault true;
      gpg.enable = mkDefault true;
    };

    home = {
      username = mkDefault username;
      stateVersion = mkDefault stateVersion;
    };
  };

  systems = {
    linux = { home.homeDirectory = mkDefault "/home/${username}"; };

    darwin = {
      # aarch64-darwin can also run x86_64 binaries with Rosetta 2, so
      nix.settings.extra-platforms = [ "x86_64-darwin" ];

      home.homeDirectory = mkDefault "/Users/${username}";
    };
  };
}

{ outputs, name, system, hostname, stateVersion, osConfig, ... }:

with outputs.lib;

mkFor system hostname {
  common = {
    home = {
      username = mkDefault name;
      stateVersion = mkDefault stateVersion;
    };

    programs = {
      vim.enable = mkDefault true;
      git.enable = mkDefault true;
      ssh.enable = mkDefault true;
      gpg.enable = mkDefault true;

      # Only needed on non-NixOS systems, also see `mkUser` in `lib/users.nix`.
      # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L18
      home-manager.enable = mkDefault (osConfig == null);
    };

    news.display = "silent";
  };

  systems = {
    linux = { home.homeDirectory = mkDefault "/home/${name}"; };

    darwin = {
      home.homeDirectory = mkDefault "/Users/${name}";

      # aarch64-darwin can also run x86_64-darwin binaries with Rosetta 2,
      # so we can use the same config for all Darwin systems.
      nix.settings.extra-platforms = [ "x86_64-darwin" ];
    };
  };
}

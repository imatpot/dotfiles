{ outputs, pkgs, system, hostname, users, ... }:

outputs.lib.mkFor system hostname {
  common = {
    nix = {
      package = pkgs.master.nix;
      settings = {
        auto-optimise-store = true;
        warn-dirty = false;
        experimental-features = [ "nix-command" "flakes" ];

        # if you want this to work with home-manager-only setups, you need to
        # manually add the user to the trusted-users list in /etc/nix/nix.conf
        # since home-manager itself cannot touch system files...
        trusted-users = users;
      };
    };
  };

  systems.darwin = {
    # aarch64-darwin can also run x86_64-darwin binaries with Rosetta 2,
    # so we can use the same config for all Darwin systems.
    nix.settings.extra-platforms = [ "x86_64-darwin" ];
  };
}

# Prevents Nix from complaining that sysmtem.nixos and system.macos options
# in Home configurations don't exist. The actual application of these happens
# in modules/linux/user-nixos-configs and modules/darwin/user-macos-configs.nix
{outputs, ...}: {
  options = {
    nixos = outputs.lib.mkOption {
      type = outputs.lib.types.attrs;
      default = {};
      description = ''
        Adds support to define additional NixOS system configurations.
        Without this module, home-manager will complain about the "nixos" option not existing.
      '';
    };
    macos = outputs.lib.mkOption {
      type = outputs.lib.types.attrs;
      default = {};
      description = ''
        Adds support to define additional Nix-Darwin system configurations.
        Without this module, home-manager will complain about the "macos" option not existing.
      '';
    };
  };
}

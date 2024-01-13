{ lib, ... }:

{
  options = {
    system = lib.mkOption {
      default = { };
      type = lib.types.attrs;
      description = ''
        Adds support to define additional NixOS system configurations.
        Without this module, home-manager will complain about the "system" option not existing.

        TODO: Document how it should be NixOS modules and the corresponding lib function.
      '';
    };
  };
}

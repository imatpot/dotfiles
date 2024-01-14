{ outputs, ... }:

{
  options = {
    system = outputs.lib.mkOption {
      type = outputs.lib.mkOptionType {
        name = "fusiable attribute set";
        merge = path: definitions:
          let values = builtins.map (v: v.value) definitions;
          in outputs.lib.fuseAttrs values;
      };

      default = { };

      description = ''
        Adds support to define additional NixOS system configurations.
        Without this module, home-manager will complain about the "system" option not existing.

        TODO: Document how it should be NixOS modules and the corresponding lib function.
      '';
    };
  };
}

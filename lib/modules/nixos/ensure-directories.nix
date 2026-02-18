{
  outputs,
  config,
  ...
}: {
  options = {
    system.ensureDirectories = outputs.lib.mkOption {
      type = with outputs.lib.types; listOf str;
      default = [];
    };
  };

  config = outputs.lib.mkIf (builtins.length config.system.ensureDirectories > 0) {
    system.activationScripts."dotfiles-ensure-directories".text = let
      dirs =
        outputs.lib.concatMapStringsSep
        " "
        (dir: ''"${dir}"'')
        config.system.ensureDirectories;
    in ''
      mkdir -p ${dirs}
    '';
  };
}

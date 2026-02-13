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

  config = {
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

{
  outputs,
  config,
  ...
}: {
  options = {
    home.ensureHomeDirectories = outputs.lib.mkOption {
      type = with outputs.lib.types; listOf str;
      default = [];
    };
  };

  config = {
    home.activation.ensureHomeDirectories =
      outputs.lib.hm.dag.entryAfter ["writeBoundary"]
      <| outputs.lib.concatMapStrings (dir: "mkdir -p ${dir}\n") config.home.ensureHomeDirectories;
  };
}

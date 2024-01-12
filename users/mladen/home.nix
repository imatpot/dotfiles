{ hostname, system, stateVersion, ... }:

let hostString = if hostname == null then "unknown host" else hostname;

in {
  home = {
    inherit stateVersion;

    username = "mladen";
    homeDirectory = "/Users/mladen";
    file."mladen.info".text = "${hostString} (${system})";
  };
}

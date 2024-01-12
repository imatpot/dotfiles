{ lib', hostname, system, stateVersion, ... }:

let hostString = if hostname == null then "unknown host" else hostname;

in {
  home = {
    inherit stateVersion;

    username = "mladen";
    homeDirectory =
      if lib'.isMacOS system then "/Users/mladen" else "/home/mladen";

    file."system.info".text = "${hostString} (${system})";

    file."mcdonalds.info" =
      lib'.mkIf (hostname == "mcdonalds") { text = "this is mcdonalds"; };
  };
}

{ lib, hostname, system, stateVersion, ... }:

let hostString = if hostname == null then "unknown host" else hostname;

in {
  imports = [ ./debug.nix ];

  system.programs.npm.enable = true;

  home = {
    inherit stateVersion;

    username = "mladen";
    homeDirectory =
      if lib.isDarwin system then "/Users/mladen" else "/home/mladen";

    file."system.info".text = "${hostString} (${system})";

    file."home.info".text = "npm";

    file."mcdonalds.info" =
      lib.mkIf (hostname == "mcdonalds") { text = "this is mcdonalds"; };
  };
}

{ config, pkgs, lib', hostname, system, stateVersion, ... }:

let hostString = if hostname == null then "unknown host" else hostname;

in {
  imports = [ ./debug.nix ];

  system.programs.npm.enable = true;

  sops.age.keyFile = if lib'.isDarwin system then
    "${config.home.homeDirectory}/Library/Application Support/sops/age/keys.txt"
  else
    "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  sops.secrets.example = lib'.mkSecretFile {
    source = ./secrets/example.crypt;
    destination = "${config.home.homeDirectory}/secrets/example";
  };

  home = {
    inherit stateVersion;
    username = "mladen";

    homeDirectory = if lib'.isDarwin system then
      "/Users/${config.home.username}"
    else
      "/home/${config.home.username}";

    file."system.info".text = "${hostString} (${system})";

    file."home.info".text = "npm";

    file."mcdonalds.info" =
      lib'.mkIf (hostname == "mcdonalds") { text = "this is mcdonalds"; };

    packages = with pkgs; [
      unstable.vscode
      unstable.discord

      nixfmt
      nil
      comma
      nom
      deadnix

      bat
    ];
  };
}

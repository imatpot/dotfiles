{ config, pkgs, lib', username, hostname, system, stateVersion, ... }:

let hostString = if hostname == null then "unknown host" else hostname;

in {
  imports = [ ./debug.nix ];

  system.programs.npm.enable = true;

  sops.age.keyFile = if lib'.isDarwin system then
    "/Users/${username}/Library/Application Support/sops/age/keys.txt"
  else
    "/home/${username}/.config/sops/age/keys.txt";

  sops.secrets.example = lib'.mkSecretFile {
    source = ./secrets/example;
    destination = "${config.home.homeDirectory}/secrets/example";
  };

  home = {
    inherit username stateVersion;

    homeDirectory = if lib'.isDarwin system then
      "/Users/${username}"
    else
      "/home/${username}";

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

{ config, pkgs, inputs, outputs, hostname, system, ... }:

{
  imports = [ ./debug.nix ];

  system.programs.npm.enable = true;

  sops.age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/aegissh" ];

  sops.secrets.example = outputs.lib.mkSecretFile {
    source = "${inputs.vault}/example.json.crypt";
    destination = "${config.home.homeDirectory}/secrets/example.json";
  };

  home = {
    # inherit stateVersion;
    # username = "mladen";

    # homeDirectory = if outputs.lib.isDarwin system then
    #   "/Users/${config.home.username}"
    # else
    #   "/home/${config.home.username}";

    file."system.info".text =
      "${if hostname == null then "unknown host" else hostname} (${system})";

    file."home.info".text = "npm";

    file."mcdonalds.info" = outputs.lib.mkIf (hostname == "mcdonalds") {
      text = "this is mcdonalds";
    };

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

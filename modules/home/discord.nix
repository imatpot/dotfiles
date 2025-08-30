{
  outputs,
  config,
  pkgs,
  ...
}: let
  discordPatcher = pkgs.writers.writePython3Bin "discord-krisp-patcher" {
    libraries = with pkgs.python3Packages; [
      pyelftools
      capstone
    ];
    flakeIgnore = [
      "E265" # from nix-shell shebang
      "E501" # line too long (82 > 79 characters)
      "F403" # ‘from module import *’ used; unable to detect undefined names
      "F405" # name may be undefined, or defined from star imports: module
      "W391"
    ];
  } (builtins.readFile ./discord-krisp-patcher.py);
in
  outputs.lib.mkConfigModule config config.modules.gui.enable "discord" {
    # Krisp: https://github.com/NixOS/nixpkgs/issues/195512

    home.packages = with pkgs.unstable; [
      vesktop
      discord
    ];

    home.activation.krispPatch = config.lib.dag.entryAfter ["writeBoundary"] ''
      run ${pkgs.findutils}/bin/find -L ${config.home.homeDirectory}/.config/discord -name 'discord_krisp.node' -exec ${discordPatcher}/bin/discord-krisp-patcher {} \;
    '';

    nixpkgs = {
      overlays = [
        (_: prev: {
          vesktop = prev.symlinkJoin {
            name = "vesktop";
            paths = [
              (prev.writeShellScriptBin "vesktop" ''
                exec ${prev.vesktop}/bin/vesktop \
                  --enable-features=UseOzonePlatform,WaylandWindowDecorations \
                  --ozone-platform-hint=auto \
                  --ozone-platform=wayland \
                  "$@"
              '')
              prev.vesktop
            ];
          };
        })
      ];
    };
  }

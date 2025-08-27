{pkgs, ...}:
pkgs.writeShellScriptBin "dots" (builtins.readFile ./dots.sh)

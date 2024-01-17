{ inputs, outputs, ... }:

{ pkgs, username, system, stateVersion, ... }:

with outputs.lib;

let
  common = {
    home = {
      username = mkDefault username;
      stateVersion = mkDefault stateVersion;
      packages = mkDefault (with pkgs; [ vim git ]);
    };
  };

  linux = if (isLinux system) then {
    home.homeDirectory = mkDefault "/home/${username}";
  } else
    { };

  darwin = if (isDarwin system) then {
    home.homeDirectory = mkDefault "/Users/${username}";
    # aarch64-darwin can also run x86_64 binaries with Rosetta 2, so
    nix.settings.extra-platforms = mkIf (isDarwin system) [ "x86_64-darwin" ];
  } else
    { };

in outputs.lib.deepMerge [ common linux darwin ]

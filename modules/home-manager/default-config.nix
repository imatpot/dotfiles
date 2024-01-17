{ inputs, outputs, ... }:

{ pkgs, username, system, hostname, stateVersion, osConfig ? null, ... }:

with outputs.lib;

let
  common = {
    programs = {
      # enable only on non-NixOS systems
      # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L18
      home-manager.enable = osConfig == null;

      vim.enable = true;
      git.enable = true;
      ssh.enable = true;
      gpg.enable = true;
    };

    home = {
      username = mkDefault username;
      stateVersion = mkDefault stateVersion;
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

in deepMerge [ common linux darwin ]

flake:

{
  systemConfigSupport = import ./system-config-support.nix flake;
  defaultConfig = import ./default-config.nix flake;
}

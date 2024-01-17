flake:

{
  defaultConfig = import ./default-config.nix flake;
  homeManager = import ./home-manager.nix flake;
  userSystemConfigs = import ./user-system-configs.nix flake;
  nixLegacyConsistency = import ./nix-legacy-consistency.nix flake;
}

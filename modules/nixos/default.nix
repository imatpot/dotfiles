flake:

{
  homeManager = import ./home-manager.nix flake;
  userSystemConfigs = import ./user-system-configs.nix flake;
}

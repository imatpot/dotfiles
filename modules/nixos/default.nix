{ inputs, outputs, ... }:

{
  homeManager = import ./home-manager.nix { inherit inputs outputs; };

  userSystemConfigs =
    import ./user-system-configs.nix { inherit inputs outputs; };
}

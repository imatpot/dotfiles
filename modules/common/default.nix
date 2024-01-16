{ inputs, outputs, ... }:

{
  nixpkgs = import ./nixpkgs.nix { inherit inputs outputs; };
}

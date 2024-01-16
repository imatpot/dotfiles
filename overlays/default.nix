{ inputs, outputs, ... }:

{
  nixpkgs = import ./nixpkgs { inherit inputs outputs; };
}

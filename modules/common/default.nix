flake:

{
  nix = import ./nix.nix flake;
  nixpkgs = import ./nixpkgs.nix flake;
}

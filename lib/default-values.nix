flake:

{
  defaultSystem = "x86_64-linux";
  defaultStateVersion = "24.05";

  defaultNixpkgsConfig = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  defaultNixpkgsOverlays = [
    (import ../overlays/unstable.nix flake)
    (import ../overlays/nur.nix flake)
  ];
}

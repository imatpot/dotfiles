{ inputs, outputs, ... }:

{
  systemConfigSupport =
    import ./system-config-support.nix { inherit inputs outputs; };
}

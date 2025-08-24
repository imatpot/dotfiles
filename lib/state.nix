{ outputs, ... }:

rec {
  defaultStateVersion = "25.11";

  # Nix-Darwin is cringe and has integer state versions.
  # https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
  defaultDarwinStateVersion = 4;

  defaultStateVersionForSystem = system:
    if outputs.lib.isDarwin system then
      defaultDarwinStateVersion
    else
      defaultStateVersion;
}

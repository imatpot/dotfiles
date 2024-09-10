{ outputs, config, pkgs, ... }:

{
  options = {
    modules.users.dev.haskell.enable =
      outputs.lib.mkEnableOption "Enable Haskell toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.haskell.enable {
    home.packages = with pkgs; [ unstable.ghc unstable.cabal-install ];
  };
}

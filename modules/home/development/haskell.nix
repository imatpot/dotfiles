{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config false "dev.haskell" {
  home.packages = with pkgs.unstable; [
    ghc
    cabal-install
    stack

    haskell-language-server
    hlint
    ormolu
  ];
}

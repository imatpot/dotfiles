{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.haskell" {
  home.packages = with pkgs.unstable; [
    ghc
    cabal-install
    stack

    haskell-language-server
    hlint
    ormolu
  ];
}

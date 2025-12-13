{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config false "dev.rust"
{
  home = {
    packages = with pkgs; [
      cargo
      rustc
      rustfmt
      clippy

      gcc
      stdenv.cc.cc.lib
      libgcc.lib

      openssl
      pkg-config
    ];

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}

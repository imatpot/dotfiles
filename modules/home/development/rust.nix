{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule config false "dev.rust"
{
  rustup.enable = outputs.lib.mkDefaultEnableOption false;
}
{
  home =
    if config.modules.dev.rust.rustup.enable
    then {
      packages = with pkgs; [
        rustup
      ];

      sessionVariables = {
        RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
        CARGO_HOME = "${config.home.homeDirectory}/.cargo";
      };
    }
    else {
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

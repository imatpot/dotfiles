{
  outputs,
  config,
  pkgs,
  ...
}: {
  options = {
    modules.users.dev.rust.enable = outputs.lib.mkEnableOption "Enable Rust toolchain";
  };

  config = outputs.lib.mkIf config.modules.users.dev.rust.enable {
    home.packages = with pkgs; [
      cargo
      rustc
    ];
  };
}

{ inputs, outputs, config, system, ... }:

let
  version = "1.0.1-a.3";
  zen = inputs.zen-browser.packages.${system}.default;

  zen' = zen.overrideAttrs (oldAttrs: rec {
    inherit version;
    src = builtins.fetchTarball {
      url =
        "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
      sha256 = "sha256:1xc30zr5zgfmnqajrppbq0mbzgd17lm3vld2l40xipmvkxqfcpi8";
    };
  });

in {
  options = {
    modules.users.zen-browser.enable =
      outputs.lib.mkEnableOption "Enable Zen Browser";
  };

  config = outputs.lib.mkIf config.modules.users.zen-browser.enable {
    home.packages = [ zen' ];
  };
}

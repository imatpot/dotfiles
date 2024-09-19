{ inputs, outputs, config, system, ... }:

let
  version = "1.0.1-a.2";
  zen = inputs.zen-browser.packages.${system}.default;

  zen' = zen.overrideAttrs (oldAttrs: rec {
    inherit version;
    src = builtins.fetchTarball {
      url =
        "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
      sha256 = "sha256:0an4i57736scjwlmiqj9w7fh950brkrlg82iyv86m51ycxsi58sk";
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

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule' config true "bitwarden"
{
  home.packages = with pkgs;
    [
      bitwarden-cli
    ]
    ++ outputs.lib.optionals config.modules.gui.enable [
      bitwarden-desktop
    ];
}

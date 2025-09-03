{
  outputs,
  system,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "bitwarden"
{
  home.packages = with pkgs;
    outputs.lib.optionals (outputs.lib.isLinux system) [
      bitwarden-cli
    ]
    ++ outputs.lib.optionals config.modules.gui.enable [
      bitwarden-desktop
    ];
}

{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config config.modules.gui.enable "dev.vscode"
{
  home.packages = with pkgs; [
    (vscode.overrideAttrs (
      self: prev: {
        desktopItems = [
          ((builtins.elemAt prev.desktopItems 0).override {
            startupWMClass = "code-url-handler";
          })
        ];
      }
    ))

    code-cursor
  ];
}

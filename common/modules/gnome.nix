{ pkgs, ... }:

{
  desktopManager.gnome3 = {
    enable = true;
  };

  services.dbus.packages = with pkgs; [
    gnome3.dconf
  ];

  gnomeRelatedPackages =
    with pkgs; [
      gnome3.gnome-tweak-tool
      gnome3.gnome-shell-extensions
      nordic
      papirus-icon-theme
      capitaine-cursors

      gnomeExtensions.dash-to-panel
      gnomeExtensions.emoji-selector
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.arc-menu

      # Gotta wait for NixOS 21.05 to add the "\u characters in JSON" support
      # nur.repos.piegames.gnome38Extensions.shelltile-657
    ];
}

{pkgs, ...}: {
  desktopManager.gnome = {
    enable = true;
  };

  services.dbus.packages = with pkgs; [gnome.dconf];

  gnomeRelatedPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnome3.gnome-shell-extensions
    nordic
    papirus-icon-theme
    capitaine-cursors

    gnomeExtensions.dash-to-panel
    gnomeExtensions.emoji-selector
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.arcmenu

    # Gotta wait for NixOS 21.05 to add the "\u characters in JSON" support... :(
    # nur.repos.piegames.gnome38Extensions.shelltile-657
    # nur.repos.piegames.gnome36Extensions.no-screen-blank-2413
  ];
}

{
  outputs,
  config,
  pkgs,
  lib,
  ...
}:

# https://github.com/runarsf/dotfiles/blob/main/modules/users/bluetooth.nix

outputs.lib.mkConfigModule config pkgs.stdenv.hostPlatform.isLinux "bluetooth" {
  modules.udev.extraRules = [ ./dualsense.rules ];

  nixos = {
    services.blueman-applet.enable = true;
    services.upower.enable = outputs.lib.mkForce false;
    boot.kernelParams = [ "usbcore.autosuspend=-1" ];
    boot.extraModprobeConfig = ''
      options btusb enable_autosuspend=0 reset=1
    '';
    services.udev = {
      packages = with pkgs; [
        steam
      ];
    };
    hardware.uinput.enable = true;
    hardware.firmware = [ pkgs.broadcom-bt-firmware ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;

      settings.General = {
        experimental = true; # show battery

        # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
        # for pairing bluetooth controller
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
      };

      settings.GATT = {
        Cache = "always";
      };

      settings.Policy = {
        AutoEnable = true;
        ReconnectAttempts = 7;
        ReconnectIntervals = "1,2,4,8,16,32,64";
      };
    };

    services.blueman.enable = true;
  };
}

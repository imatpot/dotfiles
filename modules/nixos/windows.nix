{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkModule config false "windows"
{
  version = outputs.lib.mkOption {
    type = outputs.lib.types.string;
    default = "";
    example = "11";
  };

  disk.uuid = outputs.lib.mkOption {
    type = outputs.lib.types.string;
    default = builtins.throw "dotfiles: modules.windows.disk.uuid not set";
  };
}
{
  boot.loader.grub = {
    # this will add Windows after "NixOS - All configurations" instead of in the middle
    extraInstallCommands = ''
      ${pkgs.coreutils}/bin/cat << EOF >> /boot/grub/grub.cfg

      menuentry "Windows${outputs.lib.trim " ${config.modules.windows.version}"}" {
        insmod part_gpt
        insmod fat
        search --fs-uuid --no-floppy --set=root ${config.modules.windows.disk.uuid}
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
      EOF
    '';
  };
}

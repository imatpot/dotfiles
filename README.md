# NixOS Configuration

[![NixOS 21.05](https://img.shields.io/badge/NixOS-21.05%20(Okapi)-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

NixOS is a truly fascinating distro.
Needs some getting used to, but it absolutely rocks!

## Disclaimer

It's fair to say that this is WIP, and probably forever will be.

If you *do* miraculously decide to use this on your own devices, feel free.
Don't blame me when something breaks though. But at least NixOS got your back!
Trust me, these rollbacks are golden.

## How to use

Follow the [NixOS installation manual](https://nixos.org/manual/nixos/stable/index.html#ch-installation)
up until generating the config with `nixos-generate-config --root /mnt`, then
continue here. Make sure you are root (`sudo su`, there is no password) and are
booting EFI (if `/sys/firmware/efi` doesn't exist, you're not booting EFI).

1. Clone this repository into `/mnt/etc/nixos` (or to wherever your
   [`NIX_PATH`](https://nixos.org/guides/nix-pills/nix-search-paths.html#idm140737319826896)
   is pointing to)

2. `cd` into said path

3. Remove the automatically generated `configuration.nix`. You won't need it.

4. Move the generated `hardware-configuration.nix` to `hosts/<hostname>/hardware.nix`

5. Follow the instructions in `configuration.template.nix`

6. It might be a good idea to check if the contents of all files are correct,
   specifically things like adapter names.

Continue [the manual](https://nixos.org/manual/nixos/stable/index.html#ch-installation)
from the installation step, where you run `nixos-install`. This might take a
while, depending on the selected host and its respective profile.

Once the installation is complete, you may reboot. One last, important thing:

**On first boot you'll need to log in as `root` and set the passwords of your
users manually with `passwd <username>`!**

Have fun with NixOS! You're a cool kid now ❄️

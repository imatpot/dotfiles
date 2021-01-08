# NixOS Configuration

[![NixOS 20.09](https://img.shields.io/badge/NixOS-v20.09-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

This is incredibly WIP and not (yet) properly tested!

**Don't use.**

Or do. I don't care. But don't blame me when something breaks.

## How to use

Follow [the manual](https://nixos.org/manual/nixos/stable/index.html#ch-installation)
up until generating the config with `nixos-generate-config --root /mnt`, then continue
here. Make sure you are root (`sudo su`, there is no password) and are booting EFI.

1. Clone this repository into `/mnt/etc/nixos`

2. Go into `/mnt/etc/nixos`

3. Remove the automatically generated `configuration.nix`. We don't need it.

4. Move the generated `hardware-configuration.nix` to `hosts/<hostname>/hardware.nix`

5. Follow the instructions in `configuration.template.nix`

6. It might be a good idea to check if the contents of all files are correct,
   specifically things like adapter names.

Continue [the manual](https://nixos.org/manual/nixos/stable/index.html#ch-installation)
from the installation step, where you run `nixos-install`. It might take a while, depending
on your chose host and its respective profile!

**On first boot you'll need to log in as `root` and set the passwords of your users
manually with `passwd <username>`!**

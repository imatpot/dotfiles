# ❄️ Nix-powered dotfiles

Collection of dotfiles & system configurations for personal use.

[![Nix](https://img.shields.io/badge/built%20with-Nix-5277C3.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

## Usage

Using [Nix](https://nixos.org) and the custom [`dots` command](#dots-cli), it's trivial to install and update the configurations.
The configurations provided via the [flake](https://nixos.wiki/wiki/Flakes) support [NixOS](https://nixos.org), [Nix-Darwin](https://github.com/lnl7/nix-darwin), and standalone [Home-Manager](https://github.com/nix-community/home-manager).
The former two contain a Home-Manager submodule.

### First-time setup

As long as Nix is installed, you do not need to worry about any setup. In case you have flakes enabled already, you can omit the `--experimental-features` flag.
Run the followig command to run `dots` directly from GitHub:

```sh
nix --experimental-features 'nix-command flakes' run github:imatpot/dotfiles
```

It will prompt you to clone the repository to `~/.config/dotfiles` if it doesn't exist yet.

### `dots` CLI

`dots` is installed to your configurations automatically. If it isn't you can also `nix run` it from the cloned repository, or use `nix run github:imatpot/dotfiles` to run it directly from GitHub.

`dots` tries to figure out the system it's running on & what configurations are available, and select appropriate defaults.
For example, on Darwin it will look for Nix-Darwin configurations for the current hostname, and fall back to Home-Manager configurations if none are found.
It will run `build` by default, but you can of course change this behaviour by passing appropirate arguments.

Here's a list of supported arguments:

- `build`: Build the configurations. Will prompt to `switch` to successfully built configurations.
- `test, activate`: Build the configurations and run the activation script.
- `switch`: Build the configurations, run the activation script, and set as default.
- `os, system`: Auto-detect system and matching NixOS or Nix-Darwin configuration.
- `nixos`: Auto-detect matching NixOS configuration.
- `darwin`: Auto-detect matching Nix-Darwin configuration.
- `home, home-manager`: Auto-detect matching Home-Manager configuration.

- `-f, --flake <flake>`: Specify the full flake to query for configurations.
- `-u, --url <url>`: Specify the flake URL to query for configurations. Must not include `#`-suffix.
- `-n, --name <name>`: Specify the flake output name of the configuration. Must not include `#`-prefix.
- `-r, --raw`: Whether to use `nix build` for system configurations. Only supports `build`.
- `-d, --debug`: Whether to show debug output.
- Any other argument that does not contain `-` will try to find a matching NixOS, Nix-Darwin, or Home-Manager configuration and build, test, or switch to it.

#### Examples

<details>
<summary>Let <code>dots</code> figure out and build the matching system or home configuration</summary>

```sh
dots
```
</details>

<details>
<summary>Switch to the Nix-Darwin configuration with the name <code>kitchen</code></summary>

```sh
dots switch darwin --name kitchen
```
</details>

<details>
<summary>Build (inferred) whatever the configuration with the name <code>imatpot</code> is</summary>

```sh
dots imatpot
```
</details>

<details>
<summary>Build a matching NixOS configuration from <code>/etc/nixos</code></summary>

```sh
dots nixos --url /etc/nixos
```
</details>

<details>
<summary>Test the NixOS configuration with the name <code>kitchen</code> from GitHub</summary>

```sh
dots test nixos --flake github:imatpot/dotfiles#kitchen
```

or

```sh
dots test nixos --url github:imatpot/dotfiles --name kitchen
```
</details>

<details>
<summary>Show debug information when building the user <code>imatpot</code></summary>

```sh
dots build home --name imatpot --debug
```
</details>

+++
title = "Configuration"
description = "Configuration"
weight = 1
+++

Here you can find additional steps you can perform after the installation process.

## Deleting old generations

To ensure all old generations get deleted, run nix-collect-garbage -d as your user as well as root (with sudo)

## Running a locally patched version of nix darwin

Occasionally one might want to run a patched version of nix-darwin, for example to take advantage of a pull request that has not yet been merged.

One approach is to use a local copy if the nix-darwin repo, with the relevant code checked out.

Alternatively, for e.g. the pull request at https://github.com/LnL7/nix-darwin/pull/550, one can append .patch to the URL: https://patch-diff.githubusercontent.com/raw/LnL7/nix-darwin/pull/550.patch

The patch could then be locally referenced from a flake like so (copied from this comment):

```nix
{
  description = "...";

  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs @ { self, nixpkgs-darwin, ... }:
    let
      darwin =
        let
          src = nixpkgs.legacyPackages."aarch64-darwin".applyPatches {
            name = "nix-darwin";
            src = inputs.darwin;
            patches = [
              ./patches/nix-darwin-submodules.patch
            ];
          };
        in
        nixpkgs.lib.fix (self: (import "${src}/flake.nix").outputs { inherit self nixpkgs; });
      cfg = {
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      darwinConfigurations."MyMachineName" =
        let
          system = "aarch64-darwin";
          darwinPkgs = nixpkgs-darwin.legacyPackages.${system};
        in
        darwin.lib.darwinSystem {
...
    };
}
```

## Terminfo issues

If you encounter errors during activation like tput: unknown terminal "xterm-kitty" try it from a different terminal or use

```bash
TERM=xterm-256color sudo /nix/var/nix/profiles/system/activate
```

to mitigate that temporarily.

A more suited and permanent solution is to install a more recent [ncurses](https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=ncurses) which ships with an updated terminfo db.

Another workaround is to put the following snippet into your darwin-configuration.nix:

```nix
  environment.variables = {
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };
```

### Alacritty

Alacritty [expects](https://github.com/alacritty/alacritty/blob/v0.12.0/alacritty_terminal/src/tty/mod.rs) TERMINFO to present in one of the following locations:

- $HOME/.terminfo
- /etc/terminfo
- /lib/terminfo
- /usr/share/terminfo

So you can symlink ncurses to /etc for it to get working:

```nix
environment = {
  etc = {
    terminfo = {
      source = "${pkgs.ncurses}/share/terminfo";
    };
  };

  systemPackages = [
    pkgs.ncurses
  ];
};
```

### References

See [nix-community/home-manager/issues/423] for more details.

[nix-community/home-manager/issues/423]: https://github.com/nix-community/home-manager/issues/423

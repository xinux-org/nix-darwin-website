+++
title = "Manual"
description = "Manuals"
weight = 4
+++

Nix darwin ships manualas with every commit. You can either build one yourself or use/refer to hosted manuals that are deployed with every release!

# Local

After the installation of nix-darwin, you can use `darwin-help` or `man 5 configuration.nix` command to access locally available copy of manuals with version corresponds to your installation.

# Build

Use the following commands to build manuals for desired commit/tag:

```bash
nix build github:nix-darwin/darwinpkgs/nix-darwin-24.11#manualHTML --no-write-lock-file
```

You may also check out [how we build and serve manuals](https://github.com/nix-darwin/website/blob/main/.github/workflows/deploy.yml) via our GitHub actions.

# Options explorer

If you want to quickly find/navigate through options, you can use our web ui for searching options at [options.nix-darwin.org](https://options.nix-darwin.org).

# List of hosted manuals

Here, you can find list of available manuals hosted in this domain.

- [unstable (25.05) -> master](https://nix-darwin.org/manual/unstable)
- [stable (24.11)](https://nix-darwin.org/manual/stable)

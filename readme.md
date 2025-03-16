<p align="center">
    <img src=".github/assets/header.png" alt="Nix Darwin's {Website}">
</p>

<p align="center">
    <h3 align="center">Nix Darwin options search via web.</h3>
</p>

<p align="center">
    <img align="center" src="https://img.shields.io/github/languages/top/nix-darwin/website?style=flat&logo=nixos&logoColor=5277C3&labelColor=ffffff&color=ffffff" alt="Top Used Language">
    <a href="https://github.com/nix-darwin/website/actions/workflows/deploy.yml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/nix-darwin/website/deploy.yml?style=flat&label=update%20(darwinpkgs)&logo=github&logoColor=5277C3&labelColor=ffffff&color=ffffff" alt="Deploy CI"></a>
</p>

## About

As the github organization itself, this is an unofficial website for `LnL7` and nix-darwin maintainer's effort, the nix-darwin project.

## Building & Development

Zola, a static site generator was used to build this website.

### Development

Project contains flake.nix, so...

```shell
# Enter the devenv
nix develop -c $SHELL

# Start development server
zola serve --drafts
```

### Building

Currently, you can build website just by calling `nix build`, however, it won't include all the manuals which I baked right into GitHub workflows with my spaghetti bash scripts. I'm planning to include manuals as well in website and port codes from workflows to nix build steps.

## License

This project is licensed under the MIT License - see the [LICENSE](license) file for details.

<p align="center">
    <img src=".github/assets/footer.png" alt="Nix Darwin's {Website}">
</p>

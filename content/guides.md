+++
title = "Guides"
description = "Communtiy posted guides for nix on darwin users."
weight = 5
+++

# How to migrate from Homebrew to Nix

<p align="center"><img src="/brew-to-nix.png"></p>

> I'll be honest with ya'll, you don't wanna get away from Homebrew completely, yes, I'll explain!

I've been using Nix package manager in all my MacOS machines about 3-4 months and I always kept Homebrew installed. You see, Nix is a very good package manager and with its home-manager, it becomes a good config farm as well. However, installing & managing GUI & unfree apps via Nix has been a quite painful experience for me. Sometimes, it wouldn't run properly, crash or wouldn't even start. Also, Nix doesn't have most of GUI packages that Homebrew has. Therefore, I keep homebrew and use it only for its "casks" registry to install GUI & unfree apps whereas having nix to manage dot file configurations and cli apps.

## Step 1: Remove all homebrew formulas

As you'll port everything to Nix, you don't want to keep cli apps installed via homebrew and run out of space, so we will clean all formula (alternatively, cli apps) from homebrew. You can get to see the list of all installed formulas by running:

```bash
brew list
```

However, you don't want to remove all of them one by one. This will break dependency which would potentially break homebrew itself. Instead, we will list all parent formulas without dependencies and then remove them. You can list all parent formulas by typing in your shell:

```bash
brew leaves
```

> Before you remove all formulas, make sure to save the list of cli apps you've installed on your mac somewhere. You can do this by running `brew leaves > ~/brew-formulas.txt` command.

Or, you can speed up the process by looping `brew leaves` command as shown below:

```bash
brew leaves | xargs brew rm
```

Also, run this command to keep your homebrew nice and clean:

```bash
brew autoremove && brew cleanup && brew doctor
```

## Step 2: Install Nix package manager

- That's the easiest part, no needed to ...

No, it's not. I'd love to see you try installing Nix using official shell installer. Go ahead :D and then you tell me later when your Nix installation breaks.

The problem is, the official installer will do only basic installation without further helpful configurations like `nix-comamnd` or `flakes`. There is a yet another nix installer namely `Determinate Nix installer` which does everything for you. You can check out more [here](https://zero-to-nix.com/start/install) or proceed with installation just by running this on your terminal:

> While installing, it will prompt you to either install Determinate Nix distro or Vanilla NixOS, if you are planning to use nix-darwin, go with vanilla one and say [no].

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

> Everytime your MacOS updates (even security patches), your nix breaks. Nix stores init scripts on global zshrc file and MacOS updates reset zshrc or shell files or... MacOS might update/remove disk volumes used by Nix. You can either fix it manually by writing those configs back, fighting back with diskutil or just run:
>
> ```bash
> # curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- repair
> #                                                                                            ^^^^^^
> ```

## Step 3: Get familiar with Nix and adopt it

Well, congrats! Now you have Nix installed on your machine, but this is just the tip of the iceberg. By using Nix, you should foundamentally understand that in Nix, you don't just simply install whatever you want and keep working like that (technically, you can, but it's not recommended).

### There are 3 ways of installing apps in Nix:

- **Installing for a temporary terminal session:** `nix-shell -p <package-name> <another-one>`. You do this when you want to installing something just to try out or work with it until terminal session closes.
- **Installing for a user:** `nix-env -iA nixpkgs.<package-name>`. You'll install a package just for a user, yourself. Well, people who just moved from other imperative package managers use this way, buuuut, it's not recommended if you want to go _Nix Way_.
- **Adding <package-name> to your configuration flake.** Now this is the way you should go. The thing is, Nix is all about declarativeness. You write everything: list of packages, configurations and even behaviours whether how installed packages, environment should be configured in your flake (think of it as package.json or Cargo.toml) and then apply changes to your system.

First things first, you need to either learn Nix language _(which is purely functional and if you don't know what does that mean, it will take quite some time for you to master)_ and concepts of flake and then write your config. Or, you may kickstart with templates! Personally, I used [this one](https://github.com/Misterio77/nix-starter-configs) and looked up on [this repo](https://github.com/Misterio77/nix-config) to understand whether how to further grow my config, but you can go with [this](https://github.com/the-nix-way/home-manager-config-template), [this](https://ianthehenry.com/posts/how-to-learn-nix/switching-from-homebrew-to-nix/) or [this one (beginner friendly, recommended)](https://dev.to/synecdokey/nix-on-macos-2oj3).

Feel free to look up on my [nix configurations](https://github.com/orzklv/nix) and copy paste from it. Well, right now it's pretty huge and might not be beginner friendly, but you can inspire from it like [Shakhzod Kudratov did with his own nix config](https://github.com/shakhzodkudratov/blazingly-fast). It contains configs for my macs and linux machines + configs for many software and environments.

Also, when you finish writing your flake and configurations, you can also clone your workflow to other Macs, NixOS or Linux machines. People may use a part of your configuration or you can use a part of theirs. It's all about personalizing and growing together.

## Step 4: Happy Nixing!

Now you have Nix installed and configured, you can keep exploring further and configuring your environment. You can also check out [NixOS](https://nixos.org/) and [NixOS Wiki](https://nixos.wiki/) to learn more about Nix and its ecosystem. You may also join [MacOS & Darwin chat at Xinux](https://t.me/xinux/336221) and [NixOS Reddit](https://www.reddit.com/r/NixOS/) to ask questions and get help from the community. Also, don't forget to try Nix Darwin, more at [installation](/#install)!

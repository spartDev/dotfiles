# Dotfiles

## What Is This?

This repository serves me to setup and maintain my Mac. It takes the effort out of installing everything manually.
Take anything you want, but at your own risk.

## Table of Contents

- [🔧 Install](#Install)
- [📑 Credits](#Credits)

## Setup

On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:

1. Install this repo with `curl` available:

```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/spartDev/dotfiles/master/remote-install.sh`"
```

This will clone or download, this repo to `~/dotfiles` depending on the availability of `git`, `curl` or `wget`.

2. Alternatively, clone manually into the desired location:

```bash
git clone https://github.com/spartDev/dotfiles.git ~/dotfiles
```

Use the [Makefile](./Makefile) to install everything.

```bash
cd ~/.dotfiles
make
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).

# Dotfiles-2

## Nix
1. Install Nix using [Determinate installer](https://github.com/DeterminateSystems/nix-installer)
2. Build initial `nix-darwin` configuration:
```bash
$ nix run nix-darwin/master#darwin-rebuild -- switch --flake .
```
3. Following `nix-darwin` configurations can be built with:
```bash
$ nix flake update # update the flake lock file
$ darwin-rebuild switch --flake . # rebuild our system configuration using our flake
```

## Brew
1. Install `brew` following the instructions on the [homepage](https://brew.sh/)
2. Nix will now take care of installing formulae and casks according to what we configure

Note: there does appear to be
[`nix-homebrew`](https://github.com/zhaofengli/nix-homebrew), but it seems
pretty heavy-handed and I'd rather just install brew manually.

## Changing default shell to Nix-installed Bash
1. First add `bash` installed through Nix profile to `/etc/shells`
    - Edit file using `$ sudo nvim /etc/shells`
    - Append `/run/current-system/sw/bin/bash`
2. Change shell using `$ chsh -s /run/current-system/sw/bin/bash`
    - Terminal/tmux/mac (probably) need to be restarted for change to take effect

## Using Stow
We use `-t` to specify the target directory, just to be explicit. We use `-d`,
since we place our dotfiles in the `stow` directory (this is so we can organize
them neatly, and not have them pollute the root directory of the repo).

- Use `-n` for dry-run
- Use `-v` or `--verbose[=n]` (0-5) for more output

For example:
```bash
$ stow -t ~/ -d stow -n -v alacritty # dry-run
$ stow -t ~/ -d stow alacritty
```

## Installing fonts
- Just manually install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) (these fonts add up to a quarter GiB, and I don't want to check that into this repo)

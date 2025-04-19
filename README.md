# Dotfiles-2

## TODO
- Git
- Neovim
- Yazi

## Nix
1. Install Nix using [Determinate installer](https://github.com/DeterminateSystems/nix-installer)
2. Install Nix package into profile:
```
$ nix profile install . # from dotfiles-2 directory
```

## Changing default shell to Nix-installed Bash
1. First add `bash` installed through current Nix profile to `/etc/shells`
    - Edit file using `$ sudo nvim /etc/shells`
    - Add `/users/neilweidinger/.nix-profile/bin/bash`
2. Change shell using `$ chsh -s /users/neilweidinger/.nix-profile/bin/bash`
    - Terminal/tmux/mac (probably) need to be restarted for change to take effect

## Using Stow
Make sure to run `stow` commands from root of dotfiles directory (alternatively use `-d` flag to specify stow directory). We use `-t` to specify the target directory, just to be explicit.
- Use `-n` for dry-run
- Use `-v` or `--verbose[=n]` (0-5) for more output

```
$ stow -t ~/ -d stow -n -v alacritty # dry-run
$ stow -t ~/ -d stow alacritty
```

## Installing fonts
- Just manually install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) (these fonts add up to a quarter GiB, and I don't want to check that into this repo)

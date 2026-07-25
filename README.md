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
`/etc/shells` is managed declaratively via `environment.shells` in
`nix/configuration.nix`, so after a `darwin-rebuild switch` the Nix bash is
already a valid login shell. Just set it once:
```bash
$ chsh -s /run/current-system/sw/bin/bash
```
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

# Changing default shell to Nix-installed Bash
- First add `bash` installed through current Nix profile to `/etc/shells`
    - Edit file using `$ sudo nvim /etc/shells`
    - Add `/users/neilweidinger/.nix-profile/bin/bash`
- Change shell using `$ chsh -s /users/neilweidinger/.nix-profile/bin/bash`
    - Terminal/tmux/mac (probably) need to be restarted for change to take effect

# Using Stow
- Make sure to run `stow` commands from root of dotfiles directory (alternatively use `-d` flag)
- Use `-n` for dry-run
- Use `-v` or `--verbose[=n]` (0-5) for more output

```
$ stow -t ~/ -n -v <package> # dry-run
$ stow -t ~/ <package>
```

# Installing fonts
- Unfortunately MacOS doesn't seem to like symlinks inside of `~/Library/Fonts`, so we can't use Stow and an actual file must be placed in that location instead for the font to be made available.
```
$ cp -v fonts/<font> ~/Library/Fonts/
```

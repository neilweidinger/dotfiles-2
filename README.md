# Changing default shell to Nix-installed Bash
- First add `bash` installed through current Nix profile to `/etc/shells`
    - Edit file using `$ sudo nvim /etc/shells`
    - Add `/users/neilweidinger/.nix-profile/bin/bash`
- Change shell using `$ chsh -s /users/neilweidinger/.nix-profile/bin/bash`
    - Terminal/tmux/mac (probably) need to be restarted for change to take effect

# Using Stow to place symlinks
- Make sure to run `stow` commands from root of dotfiles directory (alternatively use `-d` flag)
- Use `-n` for dry-run
- Use `-v` or `--verbose[=n]` (0-5) for more output

```
$ stow -t ~/ -n -v <package> # dry-run
$ stow -t ~/ <package>
```

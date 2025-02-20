#!/usr/bin/env bash

# Silence "The default interactive shell is now zsh" message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Enable git bash completion
source ~/.nix-profile/share/git/contrib/completion/git-completion.bash
# Enable git prompt
source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh

# See below for git-prompt options
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
export GIT_PS1_DESCRIBE_STYLE=branch
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1

# Bash prompt generator sites:
# https://bash-prompt-generator.org/
# https://robotmoon.com/bash-prompt-generator/
PROMPT_DIRTRIM=2
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='\[\e[38;5;39m\]\u\[\e[38;5;45m\]@\[\e[38;5;51m\]\h \[\e[38;5;124m\]\w\[\e[0m\]${PS1_CMD1}\[\e[96m\] \[\e[0m\]$? \[\e[38;5;208m\]λ \[\e[0m\]'

# Use nvim for man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Set default editor
export EDITOR="nvim"

# Aliases
alias cat="bat"
alias diff="delta -s"
alias less="less -i -R"
alias ls="lsd -1"

# FZF settings
export FZF_DEFAULT_OPTS="--height=40% --multi --border --layout=reverse --cycle \
                         --margin=4%,2% --prompt='λ ' --info=inline \
                         --bind 'ctrl-g:top' \
                         --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)+abort'"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

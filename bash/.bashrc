#!/usr/bin/env bash

# Silence "The default interactive shell is now zsh" message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Enable git prompt and tab completion
source ~/.git-completion.bash
source ~/.git-prompt.sh

# Colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
cyan="\[\033[0;96m\]"
orange="\[\033[38;5;208m\]"
color="\[\033[38;2;251;126;20m\]"  # rgb color code
reset="\[\033[0m\]"

export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
lambda="λ"
export PS1="$purple\u$green\$(__git_ps1)$cyan \W $orange$lambda $reset"

# Use nvim for man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Set default editor
export EDITOR="nvim"

# Aliases
alias diff="delta -s"
alias less="less -i -R"
alias cat="bat"

# FZF settings
export FZF_DEFAULT_OPTS="--height=40% --multi --border --layout=reverse --cycle \
                         --margin=4%,2% --prompt='λ ' --info=inline \
                         --bind 'ctrl-g:top' \
                         --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)+abort'"

# Source FZF bash key bindings and completion
source ~/.fzf.bash

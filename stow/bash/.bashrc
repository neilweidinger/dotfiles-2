#!/usr/bin/env bash

# Silence "The default interactive shell is now zsh" message on Mac
export BASH_SILENCE_DEPRECATION_WARNING=1

# Don't include commands prefixed with space in history
HISTCONTROL=ignorespace

# Enable git bash completion
source "$(git --exec-path)"/../../share/git/contrib/completion/git-completion.bash
# Enable git prompt
source "$(git --exec-path)"/../../share/git/contrib/completion/git-prompt.sh

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

# Set default editor
export EDITOR="nvim"

# Use `nvim` for man pages
# export MANPAGER='nvim +Man!'
# export MANWIDTH=999

# Use `bat` for man pages
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# Aliases
alias bath='bat --plain --language=help' # Pipe help text into `bath` for nice colors
alias cat='bat'
alias diff='delta -s'
alias less='less -i'
alias ls='lsd --oneline --group-dirs=first'
alias sc='/Applications/SelfControl.app/Contents/MacOS/selfcontrol-cli'
alias scr='sc is-running 2>&1 | awk '\''{print $NF}'\'

# Functions
scb() {
    # Set trap to handle Ctrl+C (SIGINT)
    trap 'echo -e "\nOperation cancelled by user"; return 1' INT

    local -r blocklist_dir='/Users/neilweidinger/Documents/Personal/selfcontrol'
    local blocklist
    blocklist=$(find $blocklist_dir -type f | fzf)

    # Check if user canceled fzf with Ctrl+C
    if [[ $? -ne 0 ]]; then
        echo "Selection cancelled"
        return 1
    fi

    local duration
    duration=$(printf "+15M\n+30M\n+1H\n+2H\n+3H\n+8H" | fzf)

    # Check if user canceled fzf with Ctrl+C
    if [[ $? -ne 0 ]]; then
        echo "Selection cancelled"
        return 1
    fi

    local timestamp
    timestamp=$(date -v "$duration" -Iseconds)

    echo "Starting SelfControl with blocklist: $blocklist, until: $timestamp"
    sc start --blocklist "$blocklist" --enddate "$timestamp"

    # Reset trap
    trap - INT
}

# Don't send analytics to homebrew
# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

# Activate homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# FZF settings
export FZF_DEFAULT_OPTS="--height=40% --multi --border --layout=reverse --cycle \
                         --margin=4%,2% --prompt='λ ' --info=inline \
                         --bind 'ctrl-g:top' \
                         --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)+abort'"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

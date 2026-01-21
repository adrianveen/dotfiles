#!/usr/bin/env bash
# ~/.bashrc
#
# fastfetch on new window

# Use bash-completion, if available, and avoid double-sourcing
if [[ $PS1 && ! ${BASH_COMPLETION_VERSINFO:-} && -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T "

# Exclude duplicate lines or lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Set default editor
export EDITOR=nvim
export VISUAL=nvim
alias vim='nvim'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH"
# Line wrap on window resize
shopt -s checkwinsize

# Aliases
# cd and ls in one
cl() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
        cd "$dir" >/dev/null || exit
        ls
    else
        echo "bash: cl: $dir: Directory not found"
    fi
}

calc() {
    echo "scale=3;$*" | bc -l
}
alias save-crash='journalctl -b -1 | grep -iE "mce|hardware|pcie|igb|error" > ~/Documents/troubleshooting/crash-$(date +%Y%m%d-%H%M).log && echo "Saved to ~/Documents/troubleshooting"'
alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
alias oc='opencode'
eval "$(starship init bash)"

# Dotfiles bare repo alias
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

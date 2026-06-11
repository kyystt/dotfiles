# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ZSH_CONF_DIR="$HOME/dotfiles/zsh/conf.d"

for config_file in "$ZSH_CONF_DIR"/*.zsh; do
    source "$config_file"
done

# Created by `pipx` on 2026-06-06 00:54:25
export PATH="$PATH:/home/kyst/.local/bin"

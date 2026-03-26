# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# cmp opts
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs false

# main opts
setopt append_history inc_append_history share_history

setopt auto_menu menu_complete
setopt autocd
setopt auto_param_slash
setopt no_case_glob no_case_match
setopt globdots
setopt extended_glob
setopt interactive_comments
unsetopt prompt_sp
stty stop undef

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTCONTROL=ignoreboth

# fzf setup
source <(fzf --zsh) # fzf history widget

# binds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^[j" backward-word
bindkey "^[k" forward-word
bindkey "^H" backward-kill-word
bindkey "^p" history-search-forward
bindkey "^n" history-search-backward
bindkey "^R" fzf-history-widget

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

NEWLINE=$'\n'
PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0} %D{%I:%M%P} %K{#3B4252}%F{ECEFF4} %n %K{#4C566A} %~ %f%k > "

echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m"

alias ls='exa -l'
alias grep='grep --color=auto'
alias v='nvim'
alias ghidra='/opt/ghidra/ghidra/ghidraRun'

export HYPRSHOJT_DIR="$HOME/Pictures/Screenshots"

#export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
#if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
#    eval "$(starship init zsh)"
#fi

export PATH=$PATH:/home/kyst/.local/share/gem/ruby/3.4.0/bin

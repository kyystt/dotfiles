precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{#FF4242}*'
zstyle ':vcs_info:git:*' stagedstr '%F{#23E974}+'
zstyle ':vcs_info:git:*' formats ' %F{8}on %F{3} %b%c%u%f'


NEWLINE=$'\n'
#PROMPT="${NEWLINE}%F{4}╭─%F{5} %n%F{white}@%F{4}%m %F{8}in %F{2}%~ %F{8}[%D{%I:%M%P}]${NEWLINE}%F{4}╰─$%f "
PROMPT="${NEWLINE}%F{4}╭─%F{5} %n%F{white}@%F{4}%m %F{8}in %F{2}%~\${vcs_info_msg_0_} %F{8}[%D{%I:%M%P}]${NEWLINE}%F{4}╰─$%f "

print -P "%F{4}   $(basename $SHELL) %F{8}• %F{5} $(uptime -p | cut -c 4-) %F{8}• %F{2} $(uname -r)%f"

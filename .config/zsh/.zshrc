
# History
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000


stty stop undef # Disable ctrl-s to freeze terminal

# My theme
source "$XDG_DATA_HOME"/zsh/plugins/git-prompt/git-prompt.zsh
source "$XDG_DATA_HOME"/zsh/plugins/git/git.zsh
source "$XDG_DATA_HOME"/zsh/plugins/prompt_info_functions/prompt_info_functions.zsh
source "$XDG_DATA_HOME"/zsh/plugins/virtualenv/virtualenv.zsh
source "$XDG_DATA_HOME"/zsh/plugins/themes-and-appearance/themes-and-appearance.zsh

source "$XDG_DATA_HOME"/zsh/plugins/bira/bira.zsh-theme

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/z/z.sh
source "$XDG_DATA_HOME"/zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh


alias config='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME'

alias mix=ncpamixer
alias ca=calcurse
alias n=nvim
alias nb=newsboat
alias gtj=". gtj"
alias grep=grep --color


zat() {
    #nohup zathura "$1" >/dev/null 2>&1 &
    setsid zathura "$1"
    #nohup zathura "$1" </dev/null >/dev/null 2>&1 &
}

bindkey -v
export KEYTIMEOUT=1


# Tab completion
autoload -U compinit

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zmodload zsh/complist

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

compinit
_comp_options+=(globdots)

# Vim key bindings for navigating autocomplete list and to delete characters properly 
bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history

bindkey "^?" backward-delete-char

# Switch between bar and line in vim mode
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = 'block' ]]; then
       echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} == '' ]] ||
         [[ $1 = 'beam' ]]; then
       echo -ne '\e[5 q'
    fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q'; } #Use beam shape cursoer for each new prompt

# In case of weird locale error, I probably did something wrong when editing the locale
export LC_ALL=en_US.UTF-8

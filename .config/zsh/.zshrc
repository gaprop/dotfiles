
# History
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000


stty stop undef # Disable ctrl-s to freeze terminal

# My theme
source "$HOME"/.local/share/zsh/plugins/git-prompt/git-prompt.zsh
source "$HOME"/.local/share/zsh/plugins/git/git.zsh
source "$HOME"/.local/share/zsh/plugins/prompt_info_functions/prompt_info_functions.zsh
source "$HOME"/.local/share/zsh/plugins/virtualenv/virtualenv.zsh
source "$HOME"/.local/share/zsh/plugins/themes-and-appearance/themes-and-appearance.zsh

source "$HOME"/.local/share/zsh/plugins/bira/bira.zsh-theme

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/z/z.sh
source "$HOME"/.local/share/zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh

alias config='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME'

alias mix=ncpamixer
alias ca=calcurse
alias n=nvim
alias nb=newsboat
alias gtj=". gtj"


zat() {
    #nohup zathura "$1" >/dev/null 2>&1 &
    setsid zathura "$1"
    #nohup zathura "$1" </dev/null >/dev/null 2>&1 &
}

bindkey -v
export KEYTIMEOUT=1


# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history

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

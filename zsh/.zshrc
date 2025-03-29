source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/autojump/autojump.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh




HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

alias ll='ls --color=auto -lah'

bindkey '^a' autosuggest-accept

PROMPT='%F{blue}%n@%m%f %F{green}%~%f %# '

export EDITOR='gvim'



source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/autojump/autojump.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh




HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

alias ll='ls --color=auto -lah'
alias svim='sudo -E vim'



bindkey '\eq' autosuggest-accept

PROMPT='%F{blue}%n@%m%f %F{green}%~%f %# '

export EDITOR='vim'



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

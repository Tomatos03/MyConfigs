# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================
# Zim Framework
# ============================================================
ZIM_HOME=${ZIM_HOME:-${HOME}/.local/share/zim}
ZIM_CONFIG_FILE=${ZIM_CONFIG_FILE:-${HOME}/.config/zimrc}
if [[ -r ${ZIM_HOME}/init.zsh ]]; then
  source ${ZIM_HOME}/init.zsh
elif [[ -r ${ZIM_HOME}/zimfw.zsh ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi

# ============================================================
# fzf-tab
# ============================================================
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:*' fzf-preview \
  'ls --color=always -1 --group-directories-first ${(Q)realpath} 2>/dev/null || \
   cat ${(Q)realpath} 2>/dev/null || \
   echo "(no preview)"'

# ============================================================
# Aliases
# ============================================================

# ---- System ----
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -lh'
alias lt='ls -lht'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias h='history'
alias md='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias svim='sudo vim'

# ---- Git ----
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gbr='git branch'
alias gpl='git pull --rebase'
alias grh='git reset HEAD~1 --soft'
alias gst='git stash'
alias gsta='git stash apply'
alias gg='git grep'

# ---- Java / Maven ----
alias mvnci='mvn clean install'
alias mvnt='mvn test'
alias mvnct='mvn clean test'
alias mvnc='mvn clean'
alias mvnp='mvn package'
alias mvno='mvn clean install -DskipTests'
alias mvnv='mvn -version'
alias mvncompile='mvn compile'

# ============================================================
# Environment
# ============================================================

# ls colors (dircolors)
if [[ -f /etc/DIR_COLORS ]] && (( $+commands[dircolors] )); then
  eval $(dircolors -b /etc/DIR_COLORS 2>/dev/null)
elif (( $+commands[dircolors] )); then
  eval $(dircolors -b)
fi

# Powerlevel10k prompt (run `p10k configure` to customize)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pi agent
export PI_FFF_MODE=override
export PATH="${HOME}/.local/share/pi-node/node-v22.23.1-linux-x64/bin:${HOME}/.pi/agent/bin:${HOME}/.local/bin:${PATH}"

my_prompt() {
  local branch
  local status

  # Verifica se estamos em um repositório Git e obtém o nome do branch
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git_branch="%F{green}($(git symbolic-ref --short HEAD))%f"
    
    # Status
    git_status=$(git status --porcelain)
    if [ -z "$git_status" ]; then
      git_status="%F{cyan}✔%f"
    else
      git_status="%F{red}✗%f"
    fi
  else
    git_branch=""
    git_status=""
  fi
  # Retorna o prompt personalizado
  echo "%F{blue}%1~%f$git_branch$git_status ➜ "
}
setopt prompt_subst
PROMPT='$(my_prompt)'

RPROMPT='%F{blue}%*'

autoload -U compinit; compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' squeeze-slashes true

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

#Comandos Básicos
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color=auto'
alias ..='cd ..'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'

#Alias
alias ins='sudo apt install'
alias del='sudo apt remove --purge'
alias clean='sudo apt autoremove'
alias sr='apt search'
alias upd='sudo apt update'
alias lupg='apt list --upgradable'
alias upg='sudo apt upgrade'
alias copy='xclip -selection clipboard'
alias fetch='clear && neofetch'
alias mute='pactl set-sink-volume @DEFAULT_SINK@ 0%'
alias unmute='pactl set-sink-volume @DEFAULT_SINK@ 100%'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


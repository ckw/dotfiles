# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

source /usr/share/autojump/autojump.sh
export TERM=xterm-256color
export PATH=/opt/ghc-7.4.2/bin:$PATH
# Colors
autoload -U colors
colors
setopt prompt_subst
set -o vi
#bindkey -v
SAVEHIST=100000
HISTSIZE=100000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt inc_append_history
setopt share_history
setopt auto_cd
setopt auto_pushd
bindkey '^R' history-incremental-search-backward
bindkey -M viins 'jk' vi-cmd-mode

# Prompt
local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

vim_ins_mode="%{$fg[cyan]%}[I]%{$reset_color%}"
vim_cmd_mode="%{$fg[yellow]%}[N]%{$reset_color%}"
vim_mode=$vim_ins_mode

PROMPT='
%~
${smiley} %{$reset_color%}${vim_mode} '
RPROMPT='%{$fg[white]%} $(~/zsh/bin/git-cwd-info)%{$reset_color%}'

# Replace the above with this if you use rbenv
# RPROMPT='%{$fg[white]%} $(~/.rbenv/bin/rbenv version-name)$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Show completion on first TAB
setopt menucomplete

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -lAh'
alias l='ls -lFhA'
alias ag='ack-grep'
alias red='redis-cli'
alias reds='redis-server'
alias sagi='sudo apt-get install'

alias P='pushd'
alias p='popd'
alias -g L='|less'
alias tf='tail -f'
alias tl='tail -f /var/log/syslog'
alias g='git'
alias gd='git diff'
alias gl='git lg'
alias glog='git log'
alias gl1='git log --oneline  --no-merges'
alias gl2='git log --oneline --name-status --no-merges'
alias gl3='git log --oneline --name-status --no-merges origin/production..HEAD'
alias gs='git status'
alias gst='git stash'
alias gcim='git commit -m'
alias gap='git add -p'
alias gpr='git pull --rebase'
alias gm='git merge'
alias gmnf='git merge --no-ff'
alias ga='git add'
alias gff='git pull --ff-only'
alias gf='git fetch'
alias gp='git push'
alias gr='git reset'
alias grh='git reset --hard'
alias gsh='git show'
alias gco='git checkout'
alias gri='git rebase -i'
alias gb='git branch'

alias zk='/usr/share/zookeeper/bin/zkCli.sh'
alias v='vim'
alias c='cat'
alias e='echo'
alias t='tig'
alias s='ssh'
alias h='htop'
alias k='kill'
alias -g wl='| wc -l'

alias pag='ps aux | ag -i'

function zle-line-finish {
  vim_mode=$vim_ins_mode
}

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}


function gsw() {
  git checkout $(git branch | ack-grep $1)
}

#haskell type
function ht(){
if [[ $2 == 't' ]]; then
  ack-grep -A 5 -i "data \w*$1\w* .*|type \w*$1\w* .*|newtype \w*$1\w* .*"
elif [[ $2 == 'f' ]]; then
  ack-grep -A 5 -i "\w*$1\w* ::"
else
  ack-grep -A 5 -i "data \w*$1\w* .*|type \w*$1\w* .*|newtype \w*$1\w* .* |\w*$1\w* ::"
fi
}

zle -N zle-keymap-select
zle -N zle-line-finish


# Load completions for Ruby, Git, etc.
autoload -U compinit && compinit -u

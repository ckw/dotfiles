# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com


# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

export TERM=xterm-256color
# Colors
autoload -U colors
colors
setopt prompt_subst
set -o vi
#bindkey -v
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
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

alias P='pushd'
alias p='popd'
alias L='less'
alias g='git'
alias zk='/usr/share/zookeeper/bin/zkCli.sh'

  function zle-line-finish {
   vim_mode=$vim_ins_mode
#    zle reset-prompt
}

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}

zle -N zle-keymap-select
zle -N zle-line-finish


# Load completions for Ruby, Git, etc.
autoload compinit
compinit


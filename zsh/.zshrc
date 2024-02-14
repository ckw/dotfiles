# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

set +x

export TERM=xterm-256color
export EDITOR=nvim
export PAGER=less
export XDG_CONFIG_HOME=$HOME/.config
export PYOPENCL_CTX='1'
export PYOPENCL_COMPILER_OUTPUT=1

if [ -d "$HOME/.asdf/asdf.sh" ]; then
  . $HOME/.asdf/asdf.sh
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
fi


if [ -d "$HOME/.stack/programs/x86_64-linux/ghc-8.10.4/bin" ]; then
  export PATH="$HOME/.stack/programs/x86_64-linux/ghc-8.10.4/bin":$PATH
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin":$PATH
fi

if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin":$PATH
fi

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

if [ -d "/usr/local/Cellar" ]; then
  export PATH=/usr/local/Cellar:$PATH
  export LOOKS_LIKE_OSX='TRUE'
  export BYOBU_PREFIX=$(brew --prefix)
fi

# Colors
autoload -U colors
colors
setopt prompt_subst
setopt rcquotes
set -o vi
#bindkey -v
SAVEHIST=100000
HISTSIZE=100000
HISTFILE=~/.zsh_history
setopt inc_append_history
setopt share_history

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

setopt auto_cd
setopt auto_pushd
bindkey '^R' history-incremental-search-backward
bindkey -M viins 'jk' vi-cmd-mode

# Prompt
local lambda="%(?,%{$fg[green]%}λ%{$reset_color%},%{$fg[red]%}λ%{$reset_color%})"

vim_ins_mode="%{$fg[cyan]%}[I]%{$reset_color%}"
vim_cmd_mode="%{$fg[yellow]%}[N]%{$reset_color%}"
vim_mode=$vim_ins_mode

PROMPT='
%~
${lambda}%{$reset_color%}${vim_mode} '
RPROMPT='%{$fg[white]%} $(~/zsh-simple/bin/git-cwd-info)%{$reset_color%}'

# Show completion on first TAB
setopt menucomplete

alias ls='ls --color=auto -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls --color=auto -alF'
alias la='ls --color=auto -lAh'
alias l='ls --color=auto -BlFhA'
alias ag='rg -i'
alias aga='rg -i -C 5'
alias r='rg -i '
alias red='redis-cli'
alias reds='redis-server'
alias sagi='sudo apt-get install'

alias -g L='|less'
alias -g fjson='|python -mjson.tool'
alias -g jqf="|jq --sort-keys '.'"
alias tf='tail -f'
alias tl='tail -f /var/log/syslog'
alias g='git'
alias gd='git diff'
alias gl='git lg'
alias glog='git log'
alias gl1='git log --oneline  --no-merges'
alias gl2='git log --oneline --name-status --no-merges'
alias gl3='git log --oneline --name-status --no-merges origin/production..HEAD'
alias gl4='git log --oneline --no-merges origin/production..HEAD'
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
alias v='nvim'
alias e='echo'
alias h='htop'
alias k='kill'
alias lc='litecoind'
alias cb='cabal build'

alias -g wl='| wc -l'

alias pag='ps aux | rg -i'

alias f='fzf'

function zle-line-finish {
  vim_mode=$vim_ins_mode
}

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}

#switch to the unique branch that contains the argument string
#or print out the list of matches
function gsw() {
  ~/dotfiles/static/git_switch.rb $1
}

function update-vim-plugins() {
  pushd ~/.vim/bundle
  for f in `ls -1` ;do pushd "$f"; git pull; popd;done
  popd
}

#haskell type
function ht(){
if [[ $2 == 't' ]]; then
  rg -A 5 -i "data \w*$1\w* .*|type \w*$1\w* .*|newtype \w*$1\w* .*"
elif [[ $2 == 'f' ]]; then
  rg -A 5 -i "[\w']*$1[\w']* ::"
else
  rg -A 5 -i "data \w*$1\w* .*|type \w*$1\w* .*|newtype \w*$1\w* .* |[\w']*$1[\w']* ::"
fi
}

function poems(){
  poems=$(shuffle "$HOME/dotfiles/static/poems")
  if [[ "$1" -gt 0 ]]; then
    tail -n "$1" "/dev/fd/0" <<< "$poems"
  else echo "$poems"
  fi
}

function gen_uuid(){
  "$HOME/dotfiles/static/gen_uuid.rb"
}

#shuffle lines in file
function shuffle(){
  perl -MList::Util -e 'print List::Util::shuffle <>' "$@"
}

function progs(){
  #TODO fix this on OSX
  ls -1 /usr/bin/ | sed '/^.\{1,6\}$/!d' | xargs whatis '{}' 2> /dev/null
}

function uuids(){
  $HOME/dotfiles/static/uuid.rb "$@"
}

zle -N zle-keymap-select
zle -N zle-line-finish


# Load completions for Ruby, Git, etc.
autoload -U compinit && compinit -u

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export PATH=$(dedup-path)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ckw/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ckw/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ckw/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ckw/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

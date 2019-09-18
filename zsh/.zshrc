# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

export TERM=xterm-256color
export EDITOR=vim
export PAGER=less
export XDG_CONFIG_HOME=$HOME/.config


pathmunge() {
    generic-pathmunge PATH "$1" "$2"
}

library-pathmunge() {
    generic-pathmunge LD_LIBRARY_PATH "$1" "$2"
    generic-pathmunge LIBRARY_PATH "$1" "$2"
}

include-pathmunge() {
    generic-pathmunge INCLUDE_PATH "$1" "$2"
    generic-pathmunge C_INCLUDE_PATH "$1" "$2"
    generic-pathmunge CPLUS_INCLUDE_PATH "$1" "$2"
}

man-pathmunge () {
    generic-pathmunge MANPATH "$1" "$2"
}

clear-paths () {
    export PATH=
    export LD_LIBRARY_PATH=
    export LIBRARY_PATH=
    export INCLUDE_PATH=
    export C_INCLUDE_PATH=
    export CPLUS_INCLUDE_PATH=
    export MANPATH=
}

addpaths() {
    # remove trailing slash if it exists
    p="${1%/}"

    if [[ -d "$p/" ]]; then
        pathmunge "$p/sbin" $2
        pathmunge "$p/bin" $2
        library-pathmunge "$p/lib" $2
        include-pathmunge "$p/include" $2
        man-pathmunge "$p/man" $2
        man-pathmunge "$p/share/man" $2
        return 0
    else
        return 1
    fi
}

generic-pathmunge() {

    # example names: PATH, LD_LIBRARY_PATH, LIBRARY_PATH, INCLUDE_PATH, C_INCLUDE_PATH
    name=$1
    pathdir="$2"

    # variable indirection is different on bash and zsh
    old_path=${(P)name}

    # make sure directory exist.

    # make sure pathdir isn't already in the path variable.
    # this doesn't work:
    # "${old_path}" != "*${pathdir}*"

    if [[ -d "${pathdir}" ]]; then

        if [ -z "${old_path}" ]; then
            export $name="${pathdir}"
        elif [ "$3" = "after" ]; then
            export $name="${old_path}":"${pathdir}"
        else
            export $name="${pathdir}":"${old_path}"
        fi
        return 0
    else
        return 1
    fi
}

if [ -d "/opt/ghc-7.4.2/bin" ]; then
  export PATH=/opt/ghc-7.4.2/bin:$PATH
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin":$PATH
fi

if [ -d "/usr/local/opt/postgresql@10/bin" ]; then
  export PATH="/usr/local/opt/postgresql@10/bin":$PATH
fi

if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin":$PATH
fi

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

#export PYTHONPATH="/usr/local/lib/python2.7/site-packages":$PYTHONPATH

pathmunge "/Users/connorwilliams/apache-cassandra-2.1.17/bin"
pathmunge "/Users/connorwilliams/go/bin"
pathmunge "/Library/TeX/texbin"

if [ -d "/usr/local/Cellar" ]; then
  export PATH=/usr/local/Cellar:$PATH
  export LOOKS_LIKE_OSX='TRUE'
  export BYOBU_PREFIX=$(brew --prefix)
fi

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
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt inc_append_history
setopt share_history
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

alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -lAh'
#alias l='ls -lFhA'
alias l='exa -l'
alias a='ag -i'
alias aga='ag -i -C 5'
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
alias v='vim'
alias e='echo'
alias h='htop'
alias k='kill'
alias lc='litecoind'
alias cb='cabal build'
alias b="stack build --fast --ghc-options -j4"

alias -g wl='| wc -l'

alias pag='ps aux | ag -i'

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
  ag -A 5 -i "data \w*$1\w* .*|type \w*$1\w* .*|newtype \w*$1\w* .*"
elif [[ $2 == 'f' ]]; then
  ag -A 5 -i "[\w']*$1[\w']* ::"
else
  ag -A 5 -i "data \w*$1\w* .*|type \w*$1\w* .*|newtype \w*$1\w* .* |[\w']*$1[\w']* ::"
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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

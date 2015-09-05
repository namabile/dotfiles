source ~/git/git-completion.bash
source ~/git/git-prompt.sh
source ~/.secrets

export EDITOR=vim

alias py='python'
alias vi='vim'
alias gdiff='gist -t diff'
alias ..="cd .."

set -o vi
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

set TERM=screen-256color

_ssh() { COMPREPLY=($(compgen -W "$(grep ^Host ~/.ssh/config | awk '{print $2}')" -- "$2")); }
complete -F _ssh ssh

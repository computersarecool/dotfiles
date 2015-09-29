# Check to see if this is interactive
if [ -z "$PS1" ]; then
  return
fi

echo bashrc has loaded

# Set alias
alias ll='ls -lahG'
alias e='emacs'

# Set tern project shortcut
nd () {
    touch .tern-project
    echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > .tern-project
}


export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\] \[\033[33;1m\]\w\[\033[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$ "
export EDITOR='emacs'
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if [ -z ${TMUX} ]; then
  tmux attach || tmux
fi


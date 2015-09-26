echo bashrc has loaded!



alias ll='ls -lahG'
#alias e='/usr/local/Cellar/emacs/24.4/bin/emacs'
alias e='emacs'
alias cg='open -a Google\ Chrome\ Canary.app'


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


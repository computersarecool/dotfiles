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


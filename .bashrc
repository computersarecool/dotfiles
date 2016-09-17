# check to see if this is interactive, if not do not read customize settings
if [[ -z $PS1 ]]; then
  return
fi

# set aliases
alias ll='ls -lahG'
alias emacs='emacs -nw'
alias e='emacs'

# define tern project shortcut
nd () {
    touch .tern-project
    echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > .tern-project
}

# Set prompt and colors
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\H\[\033[33;1m\]\w\[\033[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# add git auto-completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# notify that .bashrc has loaded
echo "Optonox, your bashrc has loaded"

# attach to a tmux session or create new one
if type -P "tmux" &>/dev/null; then
  if [ -z ${TMUX} ]; then
    tmux attach || tmux
  fi
fi

###-begin-npm-completion-###
# npm command completion script
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###


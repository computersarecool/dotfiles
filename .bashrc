# Check to see if this is interactive - if it is read customize settings
if [[ -z $PS1 ]]; then
  return
fi

# Set aliases
alias python=python3
alias ll='ls -lahG --color'
alias emacs='emacsclient -c -a "" $*'
alias e='emacs'

# Ignore commands prefixed by space
HISTCONTROL=ignorespace

# Set prompt and colors
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\H\[\033[33;1m\]\w\[\033[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$ "
export CLICOLOR=1
LS_COLORS='di=32:fi=0:ln=5;31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:'
export LS_COLORS

# Git auto-completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
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

# Notify that .bashrc has loaded
echo "The optonox bashrc file has loaded"

echo bashrc has loaded
export TERM='xterm-256color'
export PATH=/usr/local/bin:$PATH
alias ll='ls -lahG'
alias e='/usr/local/Cellar/emacs/24.4/bin/emacs'
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

# From old .bash_profile
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\] \[\033[33;1m\]\w\[\033[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$ "

export PATH=$PATH:bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
export EDITOR='emacs'

export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

export CLICOLOR=1

export LSCOLORS=GxFxCxDxBxegedabagaced
# export LSCOLORS=ExFxBxDxCxegedabagacad

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#Setting path for the Android SDK
export PATH=${PATH}:~/developer_tools/android_sdk/tools:~/developer_tools/android_sdk/platform-tools


# Setting PATH for MacPython 2.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH


# Your previous /Users/Startec/.bash_profile file was backed up as /Users/Startec/.bash_profile.macports-saved_2015-04-11_at_12:38:25

# MacPorts Installer addition on 2015-04-11_at_12:38:25: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


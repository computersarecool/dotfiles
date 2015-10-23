echo Hello Optonox, your profile has loaded

export TERM='xterm-256color'

export PATH=/usr/local/bin

export PATH=$PATH:bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

export EDITOR='emacs'

export MONGO_PATH=/usr/local/mongodb

export PATH=$PATH:$MONGO_PATH/bin

export PATH=$PATH:/opt/node-v4.2.1-linux-x64/bin

export PATH=$PATH:/opt/node-v4.2.1-linux-x64/bin/node

# MAC Settings
#Setting path for the Android SDK
#export PATH=$PATH:~/developer_tools/android_sdk/tools:~/developer_tools/android_sdk/platform-tools


# Setting PATH for MacPython 2.5
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
#export PATH


# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
#export PATH


# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH


# MacPorts Installer addition on 2015-04-11_at_12:38:25: adding an appropriate PATH variable for use with MacPorts.


#export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Load NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


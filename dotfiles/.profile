USERNAME="optonox"

# Set variables
export TERM='xterm-256color'

export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/sbin:/usr/bin:/usr/local/sbin

export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

export PATH=$PATH:~/.npm-global/bin

export EDITOR='emacsclient'
export VISUAL='emacsclient'

export GDK_BACKEND=x11

echo "The $USERNAME .profile file has loaded"

# Source bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


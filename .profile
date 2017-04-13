# Set TERM, PATH and EDITOR variables
export TERM='xterm-256color'
export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/sbin:/usr/bin:/usr/local/sbin
export PATH=$PATH:/opt/node-v4.2.1-linux-x64/bin
export PATH=$PATH:/opt/node-v4.2.1-linux-x64/bin/node
export PATH=$PATH:~/.npm-global/bin
export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin
export EDITOR='emacsclient'
export VISUAL='emacsclient'

echo "The optonox profile has loaded"

# Source bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


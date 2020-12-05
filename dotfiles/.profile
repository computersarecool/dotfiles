USERNAME=optonox

# Set terminal and display variables
export TERM=xterm-256color
export GDK_BACKEND=x11

export EDITOR=nano
export VISUAL=nano

# Set path
export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/sbin:/usr/bin:/usr/local/sbin

export PATH=$PATH:~/.npm-global/bin

export PATH=$HOME/.cargo/bin:$PATH

# Notify that .profile has loaded
echo "The $USERNAME .profile file has loaded"

# Source bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

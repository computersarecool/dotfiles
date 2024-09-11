# Set terminal, display and editor variables
export TERM=xterm-256color
export GDK_BACKEND=x11
export EDITOR=emacs
export VISUAL=emacs

# Set path
export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/sbin:/usr/bin:/usr/local/sbin

echo "The $USER .profile file has loaded"

if [ -f ~/.mac_bash_profile ]; then
    source ~/.mac_bash_profile
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

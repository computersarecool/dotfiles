#!/bin/bash
USERDIR="/cygdrive/c/Users/willy"
# install virutalenv (for python in emacs)
pip install virtualenv

# install the emacs tern server and bower
npm install -g tern
npm install -g bower

git clone https://github.com/computersarecool/dotfiles.git "$USERDIR/Documents/gitprojects/dotfiles"

# clone dot files and create links to them in homedirectories
# Enable showing dot files
shopt -s dotglob
FILES="$USERDIR/Documents/gitprojects/dotfiles"/*
for f in $FILES
do
    b=$(basename $f)
    # don't do anything with .git folder
    if [ $b == ".git" ]; then
        continue
    fi
    # handle ssh config file separately
    if [ $b == "config" ]; then
        if [ -f "$USERDIR/.ssh/$b" ]; then
            rm "$USERDIR/.ssh/$b"
        fi
        ln -s $f "$USERDIR/.ssh/$b"
        continue
    fi
  # Delete existing files
  if [ -f "$USERDIR/$b" ]; then
      rm "$USERDIR/$b"
  fi

  # Delete existing directory
  if [ -d "$USERDIR/$b" ]; then
      rm -rf "$USERDIR/$b"
  fi
  
  ln -s $f "$USERDIR/$b"
  
done

# get emacs config
rm -rf "$USERDIR/.emacs.d"
git clone https://github.com/computersarecool/dotemacs.git "$USERDIR/.emacs.d"

# return ownership of all files in user directory

# read .profile
source "$USERDIR/.profile"


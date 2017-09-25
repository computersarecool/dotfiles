#!/bin/bash

# Variables
THIS_HOME=$(eval echo ~${SUDO_USER})
USERNAME="optonox"
GITHUB_USERNAME="computersarecool"
USERDIR="/home/$USERNAME"
DOTFILES_LOCATION="$USERDIR/documents/dotfiles"
MONGO_URL="http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse"
NODE_URL="https://deb.nodesource.com/setup_8.x"

# This should be in the format: https://en.wikipedia.org/wiki/Gecos_field#format
GECOS_INFO=""

# Remove (possibly existing) user directory
rm -rf "$USERDIR"

# Create user, set temp password and add to sudo group
adduser $USERNAME --gecos "$GECOS_INFO" --disabled-password
echo "$USERNAME:temp" | sudo chpasswd
usermod -aG sudo "$USERNAME"

# Configure installation of mongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb $MONGO_URL" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Configure installation of latest version of Node.js
curl -sL curl -sL "$NODE_URL" | sudo -E bash

# Install apt packages
apt update
xargs apt install -y < apt_files.txt

# Make a new folder under new user for npm globals
mkdir -p "$USERDIR/.npm-global"
npm config set prefix "$USERDIR/.npm-global"

# Install npm packages
xargs npm install -g < apt_files.txt

# Move the ssh keys from the user running this script to the new users ssh folder
cp "$THIS_HOME/.ssh" "$USERDIR/.ssh"

# Make a documents and dotfiles folder
mkdir -p "$DOTFILES_LOCATION"

# Get location where this script is
DIR="$(dirname "${BASH_SOURCE[0]}")"

# Copy this repo into the dotfiles folder
cp -R "$DIR/../." "$DOTFILES_LOCATION"

# Make $USERNAME owner of everything in user directory
chown -R $USERNAME:$USERNAME $USERDIR

# Show dot files
shopt -s dotglob

# Loop through every file in this repo in the new user's directory
FILES="$DOTFILES_LOCATION/"*
for f in $FILES
do
    b=$(basename $f)

    # Skip .git folder
    if [ "$b" == ".git" ]; then
        continue
    fi

    # Skip README
    if [ "$b" == "README.md" ]; then
        continue
    fi

    # Skip the setupfiles_dir
    if [ "$b" == "setup_files" ]; then
        continue
    fi

    # Put SSH config file in place (make ssh folder if it does not exist)
    if [ "$b" == "config" ]; then
        mkdir -p "$USERDIR/.ssh"
        if [ -f "$USERDIR/.ssh/$b" ]; then
            rm "$USERDIR/.ssh/$b"
        fi
        ln -s $f "$USERDIR/.ssh/$b"
    fi

    # Put service files in place and enable
    if [ "$b" == "service_files" ]; then
        for sf in "$f"/*
        do
            sfb=$(basename $sf)
            ln "$sf" "/etc/systemd/system/$sfb"
            systemctl enable "$sfb"
        done
        continue
    fi

    # Delete existing files
    if [ -f "$USERDIR/$b" ]; then
        rm "$USERDIR/$b"
    fi

    # Delete existing directories
    if [ -d "$USERDIR/$b" ]; then
        rm -rf "$USERDIR/$b"
    fi

    # Create links to the user home directory
    ln -s "$f" "$USERDIR/$b"
done

# Get the newewst emacs config
rm -rf "$USERDIR/.emacs.d"
git clone "https://github.com/$GITHUB_USERNAME/dotemacs.git" "$USERDIR/.emacs.d"


# Create a tern config file in home directory
echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > "$USERDIR/.tern-config"

# Return ownership of all files in user directory
chown -R $USERNAME:$USERNAME $USERDIR

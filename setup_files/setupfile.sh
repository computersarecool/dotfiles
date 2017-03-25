#!/bin/bash

# Set variables used throughout this script
THIS_HOME=$(eval echo ~${SUDO_USER})
USERNAME="optonox"
GITHUB_USERNAME="computersarecool"
USERDIR="/home/$USERNAME"
DOTFILES_LOCATION="$USERDIR/documents/dotfiles"

# Remove (possibly existing) user directory add user and make a documents directory
rm -rf "$USERDIR"
sudo adduser $USERNAME --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "$USERNAME:temp" | sudo chpasswd
usermod -aG sudo "$USERNAME"

# Configure installing for mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Configure installing for latest version of node
curl -sL curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash

# Install all packages
apt-get update
apt-get install -y mosh python3 python3-pip virtualenv vlock emacs nodejs mongodb-org

# Update pip and install python packages
pip3 install --upgrade pip
sudo -H -u "$USERNAME" pip3 install pylint

# Make a new folder under new user for npm globals
mkdir -p "$USERDIR/.npm-global"
npm config set prefix "$USERDIR/.npm-global"

# Install npm packages (many of these are emacs add-ons)
npm install -g tern standard jshint jsonlint nodemon gulp

# Make ~/.ssh directory and copy key
mkdir "$USERDIR/.ssh"
cp "$THIS_HOME/.ssh/authorized_keys" "$USERDIR/.ssh/authorized_keys"

# Make a documents and dotfiles folder
mkdir -p "$DOTFILES_LOCATION"

# Get location where this script is
DIR="$(dirname "${BASH_SOURCE[0]}")"

# Copy this repo into the dotfile location
cp -R "$DIR/../." "$DOTFILES_LOCATION"

# Make USERNAME owner of everything in user directory
chown -R $USERNAME:$USERNAME $USERDIR

# Show dot files
shopt -s dotglob

# Loop through every file in this repo in the new user's directory
FILES="$DOTFILES_LOCATION/"*
for f in $FILES
do
    # Get file base name
    b=$(basename $f)

    # Don't do anything with .git folder
    if [ "$b" == ".git" ]; then
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
    fi

    # Skip the setupfiles_dir
    if [ "$b" == "setup_files" ]; then
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

    # Create links to the user directory (where bash looks for them)
    ln -s "$f" "$USERDIR/$b"
done

# Remove old and get new emacs config
rm -rf "$USERDIR/.emacs.d"
git clone "https://github.com/$GITHUB_USERNAME/dotemacs.git" "$USERDIR/.emacs.d"


# Make a tern config file in home directory
echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > "$USERDIR/.tern-config"

# Return ownership of all files in user directory
chown -R $USERNAME:$USERNAME $USERDIR

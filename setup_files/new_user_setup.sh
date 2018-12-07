#!/bin/bash

# This assumes git is installed
# If on WSL change your home directory: https://superuser.com/a/1134645/435434

# Variables used in this script
USERNAME="optonox"
USER_HOME="/home/$USERNAME"
GITHUB_USERNAME="computersarecool"
THIS_HOME=$(eval echo ~${SUDO_USER})
MONGO_URL="http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse"
NODE_URL="https://deb.nodesource.com/setup_8.x"
EMACS_PPA=ppa:kelleyk/emacs

DOTFILES_LOCATION="$USER_HOME/Documents/projects/dotfiles"

# Get location of this script
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# This should be in the format: https://en.wikipedia.org/wiki/Gecos_field#format
GECOS_INFO=""

# Remove existing user directory
rm -rf "$USER_HOME"

# Create user, set temp password and add to sudo group
adduser $USERNAME --gecos "$GECOS_INFO" --disabled-password
echo "$USERNAME:temp" | sudo chpasswd
usermod -aG sudo "$USERNAME"

# Add PPAs
add-apt-repository $EMACS_PPA -y

# Configure installation of mongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb $MONGO_URL" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Configure installation of node
curl -sL "$NODE_URL" | sudo -E bash -

# Update apt
apt update
apt upgrade -y --allow-unauthenticated

# Install apt packages
while read package; do
    apt install -y $package
done < apt_programs.txt

# Create an npm globals folder
mkdir -p "$USER_HOME/.npm-global"
npm config set prefix "$USER_HOME/.npm-global"

# Install NPM packages
while read package; do
    npm install -g $package
done < npm_programs.txt

# Move any ssh keys from the user running this script to the new users ssh folder
cp -TRv "$THIS_HOME/.ssh" "$USER_HOME/.ssh"

# Make the dotfiles folder
mkdir -p "$DOTFILES_LOCATION"

# Copy this repo into the dotfiles folder
cp -R "$SCRIPT_DIR/../." "$DOTFILES_LOCATION"

# Make $USERNAME owner of everything in user directory
chown -R $USERNAME:$USERNAME $USER_HOME

# Show dot files
shopt -s dotglob

# Make links to dotfiles
for full_path in "$DOTFILES_LOCATION"/dotfiles/*
do
    base_path=$(basename $full_path)

    # Make ssh folder and link to SSH config
    if [ "$base_path" == "config" ]; then
        mkdir -p "$USER_HOME/.ssh"
        ln -sf "$full_path" "$USER_HOME/.ssh/$base_path"
        continue
    fi

    # Create symbolic link to the dot file
    ln -sf "$full_path" "$USER_HOME/$base_path"
done

# Copy service files
 for full_path in "$DOTFILES_LOCATION"/service_files//*
do
    # Move service files and enable
    base_path=$(basename $full_path)
    ln -f "$full_path" "/etc/systemd/system/$base_path"
    systemctl enable "$base_path"
done

# Get emacs config
rm -rf "$USER_HOME/.emacs.d"
git clone "https://github.com/$GITHUB_USERNAME/dotemacs.git" "$USER_HOME/.emacs.d"

# Create a tern config file in home directory
echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > "$USER_HOME/.tern-config"

# Return ownership of all files in user's home directory
chown -R $USERNAME:$USERNAME $USER_HOME

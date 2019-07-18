#!/bin/bash

# Variables
NEW_USERNAME=$1
NEW_USER_HOME=$(eval echo ~$USERNAME)
THIS_USERNAME=$SUDO_USER
THIS_USER_HOME=$(eval echo ~$USERNAME)
GITHUB_USERNAME="computersarecool"
SCRIPT=$(realpath -s $0)
REPO_PATH="$(dirname "$(dirname "$SCRIPT")")"
EMACS_PPA=ppa:kelleyk/emacs
TEMP_PASSWORD="temp"

DOTFILES_LOCATION="$USER_HOME/Documents/projects/dotfiles"

# Get location of this script
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# This should be in the format: https://en.wikipedia.org/wiki/Gecos_field#format
GECOS_INFO=""

# Remove new user home directory
rm -rf "$NEW_USER_HOME"

# Create new user, set temp password and add to sudo group
adduser ${NEW_USERNAME} --gecos "$GECOS_INFO" --disabled-password
echo "$NEW_USERNAME:$TEMP_PASSWORD" | sudo chpasswd
usermod -aG sudo "$NEW_USERNAME"

# Add PPA(s)
add-apt-repository ${EMACS_PPA} -y

# Update apt
apt update
apt upgrade -y --allow-unauthenticated

# Install apt packages
while read package; do
    apt install -y ${package}
done < apt_programs.txt

# Create npm globals folder
mkdir -p "NEW_USER_HOME/.npm-global"
npm config set prefix "NEW_USER_HOME/.npm-global"

# Install npm packages
while read package; do
    npm install -g ${package}
done < npm_programs.txt

# Make the dotfiles folder
mkdir -p "$DOTFILES_LOCATION"

# Copy this repo into the dotfiles folder
cp -R "$SCRIPT_DIR/../." "$DOTFILES_LOCATION"

# Make $USERNAME owner of everything in user directory
chown -R ${THIS_USERNAME}:${THIS_USERNAME} ${THIS_USER_HOME}

# Show dot files
shopt -s dotglob

# Make symlinks to all dotfiles
for full_path in "$DOTFILES_LOCATION"/dotfiles/*
do
    base_path=$(basename $full_path)
    ln -sf "$full_path" "$THIS_USER_HOME/$base_path"
done

# Link and enable service files
for full_path in "$DOTFILES_LOCATION"/service_files//*
do
    base_path=$(basename $full_path)
    ln -f "$full_path" "/etc/systemd/system/$base_path"
    systemctl enable "$base_path"
done

# Get the latest emacs config
rm -rf "$THIS_USER_HOME/.emacs.d"
git clone "https://github.com/$GITHUB_USERNAME/dotemacs.git" "$$THIS_USER_HOME/.emacs.d"

# Create a tern config file in home directory
echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > "$THIS_USER_HOME/.tern-config"

# Return ownership of all files in user's home directory
chown -R ${THIS_USERNAME}:${THIS_USERNAME} ${$THIS_USER_HOME}

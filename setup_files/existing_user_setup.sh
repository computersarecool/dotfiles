#!/bin/bash

# This assumes git is installed

# Variables used throughout this script
USERNAME=$SUDO_USER
GITHUB_USERNAME="computersarecool"
SCRIPT=$(realpath -s $0)
REPO_PATH="$(dirname "$(dirname "$SCRIPT")")"
USER_HOME=$(eval echo ~$USERNAME)
EMACS_PPA=ppa:kelleyk/emacs

# Set flag if on WSL
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    IS_WINDOWS=true
fi

# Add PPA(s)
add-apt-repository $EMACS_PPA -y

# Update apt
apt update
apt upgrade -y --allow-unauthenticated

# Install apt packages
while read package; do
    apt install -y $package
done < apt_programs.txt

# Create npm globals folder
mkdir -p "$USER_HOME/.npm-global"
npm config set prefix "$USER_HOME/.npm-global"

# Install npm packages
while read package; do
    npm install -g $package
done < npm_programs.txt

# Show files that start with a dot
shopt -s dotglob

# Make symlinks to all dotfiles
for full_path in "${REPO_PATH}"/dotfiles/*
do
    base_path=$(basename $full_path)
    ln -sf "$full_path" "$USER_HOME/$base_path"
done

# Link and enable service files if not on Windows
if [[ -z "$IS_WINDOWS" ]]; then
  for full_path in "${REPO_PATH}/service_files/"*
  do
      base_path=$(basename $full_path)
      ln -f "$full_path" "/etc/systemd/system/$base_path"
      systemctl enable "$base_path"
  done
fi

# Get the latest emacs config
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

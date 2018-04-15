#!/bin/bash

# This assumes git is installed
# If on WSL change your home directory: https://superuser.com/a/1134645/435434

# Variables used in this script
USERNAME=$SUDO_USER
GITHUB_USERNAME="computersarecool"
SCRIPT=$(realpath -s $0)
REPO_PATH="$(dirname "$(dirname "$SCRIPT")")"
USER_HOME=$(eval echo ~$USERNAME)
EMACS_PPA=ppa:kelleyk/emacs
MONGO_URL="http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse"
NODE_URL="https://deb.nodesource.com/setup_8.x"

# Set variable if on Windows
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    IS_WINDOWS=true
fi

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

# Show files that start with a dot
shopt -s dotglob

# Make links to all dotfiles
for full_path in "${REPO_PATH}"/dotfiles/*
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

# Copy service files if not on Windows
if [[ -z "$IS_WINDOWS" ]]; then
  for full_path in "${REPO_PATH}/service_files/"*
  do
      # Move service files and enable
      base_path=$(basename $full_path)
      ln -f "$full_path" "/etc/systemd/system/$base_path"
      systemctl enable "$base_path"
  done
fi

# Get the newewst emacs config
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

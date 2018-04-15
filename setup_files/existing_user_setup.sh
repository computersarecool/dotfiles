#!/bin/bash

# This assumes git is installed
# If on WSL [change your home directory](https://superuser.com/a/1134645/435434)

# Variables used in this script
GITHUB_USERNAME="computersarecool"
USERNAME=$SUDO_USER
SCRIPT=`realpath -s $0`
REPO_PATH="$(dirname "$(dirname "$SCRIPT")")"
USER_HOME=$(eval echo ~$USERNAME)
MONGO_URL="http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse"
NODE_URL="https://deb.nodesource.com/setup_8.x"

# Check if on windows
# https://stackoverflow.com/questions/38859145/detect-ubuntu-on-windows-vs-native-ubuntu-from-bash-script

# Add PPAs
add-apt-repository ppa:kelleyk/emacs -y

# Configure installation of mongo and node
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb $MONGO_URL" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
curl -sL curl -sL "$NODE_URL" | sudo -E bash

# Install apt packages
apt update
while read package; do
    apt install -y $package
done < apt_programs.txt

# Create an npm globals folder
mkdir -p "$USER_HOME/.npm-global"
npm config set prefix "$USER_HOME/.npm-global"

# Install NPM packages
while read package; do
    npm intall -y $package
done < apt_files.txt

# Show files that start with a dot
shopt -s dotglob

# Copy service files if not on Windows
# TODO: Not on windows
#    if [[ -z "$IS_WINDOWS" ]]; then
#    fi

# TODO: Validate
for full_path in "${REPO_PATH}/service_files/"*
do
    # Move service files and enable
    sfb=$(basename $full_path)
    ln "$sf" "/etc/systemd/system/$sfb"
    systemctl enable "$sfb"
done


# Make links to all dotfiles
for full_path in "${REPO_PATH}/dotfiles/"*
do
    base_path=$(basename $full_path)

    # Make .ssh folder and link to SSH config
    if [ "$base_path" == "config" ]; then
        mkdir -p "$USER_HOME/.ssh"
        if [ -f "$USER_HOME/.ssh/$base_path" ]; then
            rm "$USER_HOME/.ssh/$base_path"
        fi
        ln -s $full_path "$USER_HOME/.ssh/$base_path"
    fi

    # Delete file if it already exists
    if [ -f "$USER_HOME/$base_path" ]; then
        rm "$USER_HOME/$base_path"
    fi

    # Create symbolic link to the existing file
    ln -s "$f" "$USER_HOME/$base_path"
done

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

#!/bin/bash

# Pass in a command line argument if this is on Windows
# Set variables used with this script
IS_WINDOWS="$1"
GITHUB_USERNAME="computersarecool"
MONGO_URL="http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse"
NODE_URL="https://deb.nodesource.com/setup_8.x"

CURRENT_USER=$SUDO_USER

# Set path to home directory based on if on Windows
if [[ -n "$IS_WINDOWS" ]]; then
    USERDIR="/mnt/c/Users/willy"
else
    USERDIR="/home/$CURRENT_USER"
fi

DOTFILES_LOCATION="$USERDIR/Documents/projects/dotfiles"


# Configure installation of mongoDB and node
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb $MONGO_URL" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
curl -sL curl -sL "$NODE_URL" | sudo -E bash

# Install apt packages
apt update
while read p; do
    apt install -y $p
done < apt_programs.txt

# Make and set an npm globals folder and install npm packages
mkdir -p "$USERDIR/.npm-global"
npm config set prefix "$USERDIR/.npm-global"
while read p; do
    npm intall -y $p
done < apt_files.txt

# Show files starting with a dot
shopt -s dotglob

# Loop through every dotfile
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

    # Place service files and enable if on Windows
    if [[ -z "$IS_WINDOWS" ]]; then
        if [ "$b" == "service_files" ]; then
            for sf in "$f"/*
            do
                # TODO: Check this part
                sfb=$(basename $sf)
                ln "$sf" "/etc/systemd/system/$sfb"
                systemctl enable "$sfb"
            done

           continue
        fi
    fi

    # Make a link to SSH config
    if [ "$b" == "config" ]; then
        mkdir -p "$USERDIR/.ssh"
        if [ -f "$USERDIR/.ssh/$b" ]; then
            rm "$USERDIR/.ssh/$b"
        fi
        ln -s $f "$USERDIR/.ssh/$b"
    fi

    # Delete file in destination
    if [ -f "$USERDIR/$b" ]; then
        rm "$USERDIR/$b"
    fi

    # Delete directory in destination
    if [ -d "$USERDIR/$b" ]; then
        rm -rf "$USERDIR/$b"
    fi

    # Create symbolic link to the dotfile in this repo
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

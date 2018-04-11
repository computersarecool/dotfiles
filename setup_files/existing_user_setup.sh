#!/bin/bash

# If on WSL [change your home directory](https://superuser.com/a/1134645/435434)

# Set variables used in this script
GITHUB_USERNAME="computersarecool"
USERNAME=$SUDO_USER
MONGO_URL="http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse"
NODE_URL="https://deb.nodesource.com/setup_8.x"
DOTFILES_LOCATION="$HOME/Documents/projects/dotfiles"

# Set path to system home directory
# Check if on windows
# https://stackoverflow.com/questions/38859145/detect-ubuntu-on-windows-vs-native-ubuntu-from-bash-script

# Configure PPAs
add-apt-repository ppa:kelleyk/emacs -y

# Configure installation of mongo and node
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb $MONGO_URL" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
curl -sL curl -sL "$NODE_URL" | sudo -E bash

# Install apt packages
apt update
while read p; do
    apt install -y $p
done < apt_programs.txt

# Make and set an npm globals folder and install npm packages
mkdir -p "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"
while read p; do
    npm intall -y $p
done < apt_files.txt

# Show files starting with a dot
shopt -s dotglob

# Move files into correct locations
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

    # Place service files and enable if not on Windows
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
        mkdir -p "$HOME/.ssh"
        if [ -f "$HOME/.ssh/$b" ]; then
            rm "$HOME/.ssh/$b"
        fi
        ln -s $f "$HOME/.ssh/$b"
    fi

    # Delete existing file
    if [ -f "$HOME/$b" ]; then
        rm "$HOME/$b"
    fi

    # Delete existing directory
    if [ -d "$HOME/$b" ]; then
        rm -rf "$HOME/$b"
    fi

    # Create symbolic link to the dotfile in this repo
    ln -s "$f" "$HOME/$b"
done

# Get the newewst emacs config
rm -rf "$HOME/.emacs.d"
git clone "https://github.com/$GITHUB_USERNAME/dotemacs.git" "$HOME/.emacs.d"


# Create a tern config file in home directory
echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > "$HOME/.tern-config"

# Return ownership of all files in user's home directory
chown -R $USERNAME:$USERNAME $HOME

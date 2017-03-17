#!/bin/bash
USERDIR="/home/optonox"

# Add all repos
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Install all packages
apt-get update
apt-get install -y git
apt-get install -y mosh
apt-get install -y vlock
apt-get install -y emacs
apt-get install -y mongodb-org

# Upgrade and install python packages
pip3 install --upgrade pip
pip3 install virtualenv
pip3 install pylint

# Configure installing for latest version of node
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs

# Make a new folder for npm globals
mkdir -p "$USERDIR/.npm-global"
npm config set prefix "$USERDIR/.npm-global"
export PATH="$USERDIR/.npm-global:$PATH"

# Install npm packages (many of these are emacs add-ons)
npm install -g tern
npm install -g standard
npm install -g jshint
npm install -g jsonlint
npm install -g nodemon
npm install -g gulp

# Make optonox owner of everything in user directory
chown -R optonox:optonox $USERDIR

# Clone dot files and create links to them in $HOME
# Show dot files
shopt -s dotglob
FILES="$USERDIR/documents/gitprojects/dotfiles"/*
for f in $FILES
do
    # Get file base name
    b=$(basename $f)
    # don't do anything with .git folder
    if [ $b == ".git" ]; then
        continue
    fi

    # ssh config file is a special case, put it in a special place
    if [ $b == "config" ]; then
        if [ -f "$USERDIR/.ssh/$b" ]; then
            rm "$USERDIR/.ssh/$b"
        fi
        ln -s $f "$USERDIR/.ssh/$b"
    fi

    # Move and enable service files
    if [ $b == "service_files" ]; then
        SERVICEFILES="$USERDIR/documents/gitprojects/dotfiles/service_files"/*
        for sf in $SERVICEFILES
        do
            sfb=$(basename $sf)
            ln $sf "/etc/systemd/system/$sfb"
            systemctl enable $sfb
        done
    fi

    # Skip over the setupfiles_dir
    if [ $b == "setup_files" ]; then
        continue
    fi

    # delete existing files if they exist
    if [ -f "$USERDIR/$b" ]; then
        rm "$USERDIR/$b"
    fi

    # delete existing directories if they exit
    if [ -d "$USERDIR/$b" ]; then
        rm -rf "$USERDIR/$b"
    fi

    # Create links to the userdirectory (where bash looks for them)
    ln -s $f "$USERDIR/$b"
done

# get emacs config
rm -rf "$USERDIR/.emacs.d"
git clone https://github.com/computersarecool/dotemacs.git "$USERDIR/.emacs.d"


# Make a tern config file in home directory
echo "{
    \"plugins\": {
        \"node\": {
        }
    }
 }" > "$USERDIR/.tern-config"

# Return ownership of all files in user directory
chown -R optonox:optonox $USERDIR

source "$USERDIR/.profile"

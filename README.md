# dotfiles
*A set of files to configure a Ubuntu Linux server*
 
Amazon AWS AMI `star_server2` is based on this repo.

## What this repo does:
This repo contains several scripts to configure Linux.
- A setup bash script which will create a user, set up that user's environment, install packages and install programs (works on Linux)

- Service files to configure services on start (works on Linux)

- Dot files to configure a user's environment (Works on Linux and WSL)

- A modified version of the setup bash script which configures an existing user's environment (Works on Linux and WSL)
 
## Tested on:
- Linux (Amazon AWS Ubuntu 16.04 AMI)
- Windows 10 (Windows Subsystem for Linux)

## To use:
### To run the full setup script:
```shell
sudo ${PATH_TO_THIS_REPO}/setup_files/setup_file.sh
# The user password is set to temp
sudo passwd optonox
```

### To configure an existing user's account:
```shell
# cd to ${PATH_TO_THIS_REPO}/setup_files/
sudo ./existing_user_setup.sh [WINDOWS]

# If using Windows Subsytem for Linux pass any string as the arguement [WINDOWS] otherwise leave it blank
```

### The setup file in this repo creates:
- [this user](setup_files/setup_file.sh#L5)

### The setup file in this repo installs packages from the following lists:
- [apt install list](setup_files/apt_files.txt)
- [npm install list](setup_files/npm_files.txt)

### The setup file in this repo sets up `systemd` service files for:
- Emacs (set to run as a daemon)

### This repo contains the following dotfiles:
- `.bash_logout`
- `.bashrc`
- `.profile`
- `config` (example ssh config file)

### License

:copyright: Willy Nolan 2017 

[MIT License](http://en.wikipedia.org/wiki/MIT_License)


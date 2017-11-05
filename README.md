# dotfiles
*A set of files to configure a Ubuntu Linux machine*
 
This is tested on the Amazon AWS Ubuntu 16.04 AMI.
 
Amazon AWS AMI `star_server2` is based off this repo.

There are a few parts to this repository:
- A setup bash script which will create a user, set up that user's environment, install packages and install programs (works on Linux)
- Service files, to configure services on start
- `.` files to configure a user's environment
- A modified version of the setup bash script which configures an existing user's environment (Works on Linux and WSL)

### To run the full setup script:
```shell
sudo ${PATH_TO_THIS_REPO}/setup_files/setup_file.sh
# Change the user password
sudo passwd optonox
```

The password for the user account is initially set to `temp`

### To configure an existing user's account:
```shell
sudo ${PATH_TO_THIS_REPO}/setup_files/existing_user_setup.sh [WINDOWS]

If using Windows Subsytem for Linux pass any string as the arguement [WIINDOWS] otherwise leave blank
```

### The setup file in this repo creates:
- [this user](setup_files/setupfile.sh#L5)

### The setup file in this repo installs packages from the following lists:
- [apt install list](setup_files/apt_files.txt)
- [npm install list](setup_files/npm_files.txt)

### The setup file in this repo sets up `systemd` service files for:
- Emacs (set to run as a daemon)

### This repo contains the following dotfiles:
- `.bash_logout`
- `.bashrc`
- `.profile`
- `.tmux.conf` (unused)
- `config` (example ssh config file)

### License

:copyright: Willy Nolan 2017 

[MIT License](http://en.wikipedia.org/wiki/MIT_License)


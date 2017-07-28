# dotfiles
*A set of files to configure a Ubuntu Linux machine*
 
 This is tested on the Amazon AWS Ubuntu 16.04 AMI
 
 For added convenience Amazon AWS AMI `star_server2` is based off this repo


There are three parts to this repo:
- A setup bash script which will create a user, set up that user's environment, install packages and install programs
- Service files, to configure services on start
- `.`files to configure the environment

### To start:
```shell
git clone https://github.com/computersarecool/dotfiles
sudo dotfiles/setupfile/setupfile.sh
# Change the user password
sudo passwd optonox
```
The password for the user account is set to `temp` by default

### The setup file in this repo creates the user:
- `optonox`

### The setup file in this repo installs:
##### via `apt-get install`
- mosh
- vlock
- emacs
- node / npm (from updated repo)
- mongodb (from updated repo)
- python3
- pip3
- virtualenv
- pylint

##### via `npm`
- tern
- standard
- jhint
- jsonlint
- nodemon
- gulp

### The setup file in this repo sets up `systemd` files for:
- Emacs (set to run as a daemon)

### This repo contains the following dotfiles:
- `.bash_logout`
- `.bashrc`
- `.profile`
- `.tmux.conf` (unused)
- SSH Config (example file)

### License

:copyright: Willy Nolan 2017 

[MIT License](http://en.wikipedia.org/wiki/MIT_License)


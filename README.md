# dotfiles
This is a set of files to configure a Ubuntu Linux machine how I like it.

There are three parts to this repo:
- A setup bash script which will create a user, install packages and get programs
- Service files, to configure services on start
- `.`files to configure the environment to how I like it

### To start run:
```shell
git clone https://github.com/computersarecool/dotfiles
sudo dotfiles/setupfile/setupfile.sh
sudo passwd optonox (it will be set to temp otherwise)
```

### The setup file in this repo creates the user:
- `optonox`

### The setup file in this repo installs:
##### via `apt-get install`
- git
- mosh
- vlock
- emacs
- mongodb
- pip3

##### via `pip3`
-	virtualenv
-	pylint

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
- .bash_logout
- .bashrc
- .profile
- .tmux.conf (unused)
- SSH Config (example file)

##### TODO
- Look into python virtualenv not installing correctly and causing problems in emacs
- Delete default ubuntu user that comes with AMI
- Logout when script finishes (to force reading of ~/.profile upon subsequent logins)

### License
:copyright: Willy Nolan 2017 
[MIT](http://en.wikipedia.org/wiki/MIT_License)

# dotfiles
This is a set of files to configure a Ubuntu Linux machine how I like it.

It contains three things
- A setup bash script which will install packages and get programs
- Service files, to configure services on start
- `.`files to configure the environment to how I like it

### This installs
##### via `apt-get install`
- git
- mosh
- vlock
- emacs
- mongodb

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

##### This sets up service (`systemd` files for):
- Emacs (set to run as a daemon)

##### This contains the following dotfiles
- .bash_logout
- .bashrc
- .profile
- .tmux.conf (unused)
- SSH Config (example file)

### License
:copyright: Willy Nolan 2017 
[MIT](http://en.wikipedia.org/wiki/MIT_License)

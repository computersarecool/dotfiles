# dotfiles
*A set of files to configure Ubuntu Linux*

## Description
This repo contains several scripts and files to configure Ubuntu Linux including:

- A setup bash script which will create a user, configure that user's environment and install packages (Linux only)

- A modified version of that setup script which will configure an existing user's environment and install packages (Linux and WSL)

- `.` files to configure a user's environment (Linux and WSL)

- `systemd` Service files to configure services on start (Linux only)

## Tested On
- Linux (Ubuntu 17.10)
- Windows 10 (Ubuntu on Windows Subsystem for Linux)

## To Use
### Setup script
- This will create a user with [this username](setup_files/setup_file.sh#L4)
- The user password will be set to `temp`

```shell
sudo ${PATH_TO_THIS_REPO}/setup_files/setup_file.sh
sudo passwd optonox
```

### Configure existing user
- Set [username](setup_files/existing_user_setup.sh#L4)
- If on WSL [change your home directory to match a typical Windows home directory](https://superuser.com/a/1134645/435434)

```shell
# cd ${PATH_TO_THIS_REPO}/setup_files/
sudo ./existing_user_setup.sh ${WINDOWS}
```

## Project Structure
- `dotfiles` contains all of the dotfiles
- `setup_files` contains scripts used to setup a user
- `service_files` contains `systemd` service files

## Extra Notes
### The setup file in this repo installs packages packages and programs from the following:
- [apt install list](setup_files/apt_files.txt)
- [npm install list](setup_files/npm_files.txt)

### The setup file in this repo sets up `systemd` service files for:
- Emacs (set to run as a daemon)

### This repo contains the following dotfiles:
- `.bash_logout`
- `.bashrc`
- `config` (an example ssh config file)
- `.profile`

### License

:copyright: Willy Nolan 2017 

[MIT License](http://en.wikipedia.org/wiki/MIT_License)


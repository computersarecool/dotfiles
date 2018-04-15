# dotfiles
*A set of files to configure Ubuntu Linux*

## Description
This repo contains several scripts and files to configure Ubuntu Linux including:

- A setup bash script that will create a user, configure that user's environment and install packages (Linux only)

- A modified version of that setup script that will configure an existing user's environment and install packages (Linux and WSL)

- `.` files to configure a user's environment (Linux and WSL)

- Service files to configure services on start via `systemd` (Linux only)

## Tested On
- Linux (Ubuntu 17.10)
- Windows 10 (Ubuntu on Windows Subsystem for Linux)

## To Use
### Set up and configure new user
- Install `git`
- This will create a user with [this username](setup_files/setup_file.sh#L4)
- The user password will be set to `temp`
- Run `sudo ${PATH_TO_THIS_REPO}/setup_files/new_user_setup.sh`

### Configure existing user
- Install `git`
- Set [username](setup_files/existing_user_setup.sh#L4)
- If on WSL [change your home directory to match the normal Windows home directory](https://superuser.com/a/1134645/435434)

```shell
# cd ${PATH_TO_THIS_REPO}/setup_files/
sudo ./existing_user_setup.sh ${WINDOWS}
```

## Project Structure
- `dotfiles` contains all of the dotfiles
- `setup_files` contains scripts used to setup a user
- `service_files` contains `systemd` service files

## Extra Notes
### The files in this repo install packages and programs from the following:
- [apt install list](setup_files/apt_files.txt)
- [npm install list](setup_files/npm_files.txt)

### License

:copyright: Willy Nolan 2017 

[MIT License](http://en.wikipedia.org/wiki/MIT_License)


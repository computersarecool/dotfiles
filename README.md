# dotfiles
*Files to configure Ubuntu Linux*


## Description
This repo contains several scripts and files to configure Ubuntu Linux including:

- A setup bash script that will create a user, configure that user's environment and install packages (only works on Linux)

- A modified version of that setup script that will configure an existing user's environment and install packages (works on Linux and WSL)

- `.` files to configure a user's environment (work on Linux and WSL)

- Service files to configure services on start via `systemd` (works on Linux only)


### Dependencies
- `git`

## Tested On
- Linux (Ubuntu 18.04)
- Windows 10 (Ubuntu on Windows Subsystem for Linux)


## To Use
- Clone this repo to `~/Documents/projects/dotfiles`
- Remove the automatically added text [below this line](dotfiles/.bashrc#L117) in `.basrhc`


### To create and configure a new user
- Run:
    ```shell
    cd setup_files
    sudo chmod +x new_user_setup.sh
    sudo ./new_user_setup.sh ${NEW_USERNAME_YOU_WANT}
    sudo chmod password ${NEW_USERNAME_YOU_WANT} # Password is initally set to temp 
    ```


### To configure an existing user
- Run:
    ```shell
    cd setup_files/
    sudo chmod +x existing_user_setup.sh
    sudo ./existing_user_setup.sh
    source ~/.profile
    ```

## Project Structure
- `dotfiles` contains all of the dotfiles
- `setup_files` contains scripts used to setup a user
- `service_files` contains `systemd` service files

## Extra Notes
### The files in this repo install packages and programs from the following:
- [apt install list](setup_files/apt_files.txt)
- [npm install list](setup_files/npm_files.txt)
- Due to the hardcoded references to github repos and specific settings, this is really meant to be a starting point, not used as is
- **Warning:** This repo contains scripts that move and delete files. Please understand everything the scripts do before you use them


### License

:copyright: Willy Nolan 2017 

[MIT License](http://en.wikipedia.org/wiki/MIT_License)

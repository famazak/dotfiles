# My Dotfiles

These are the different configurations I use for my local setup on MacOS.  Feel free to take anything you may find useful and modify it to suit your needs.  **Disclaimer:** this mostly serves as a utility for me to track my preferred configurations and as a guide/reminder for steps to perform when I setup a new MacOS machine -- considering this doesn't happen very often, `setup.sh` may not function 100% and may need to be stepped through.

Below are some general purpose notes.

## etc

This is for misc. items such as color schemes, themes and fonts (although I primarily install my desired fonts with Homebrew now).

## stow

This is where I store my configurations for different services -- I use a single directory to make establishing symlinks easier via GNU Stow.

### stow/git

This is my Git config file.  Nothing too special here except some global Git settings that I prefer.

### stow/nano

I have some custom plugins installed for nano to make basic text editing a bit easier.

### stow/vim

I'm not a regular vim user but I like to keep a lightweight configuration for the occassions where I do need to use vim.

### stow/zsh

zsh configuration files.  Nothing too complicated.

## Brewfile

I use this to track and manage the casks/packages I install with Homebrew.

## setup.sh

This is the install script to bootstrap a new machine.  **Like I mentioned above, this isn't always tested and may not work 100% without some tweaks.  It mostly serves as a guide/set of reminders.**

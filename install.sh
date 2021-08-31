# This is an install script I use to get up and running on a new macOS device.
# PLEASE USE AT YOUR OWN RISK!  This is configured based on my usage, however if you
# find any of these snippets useful, feel free to use them and modify them to your need.

# Let's do some initial git and GitHub setup
# first, set the git config
git config --global user.name famazak
git config --global user.email zakfama58@gmail.com

# generate and add SSH key to GitHub
# IMPORTANT: YOU NEED A PERSONAL ACCESS TOKEN FROM GITHUB FOR THIS WITH
# AT LEAST write:public_key PERMISSIONS
read -p "Enter github email: " email
echo "Using email $email"
read -p "What would you like to name your ssh key? " key_name
echo "Great!  Generating SSH key for $email named $key_name"
ssh-keygen -t rsa -b 4096 -C "$email" -N "" -f ~/.ssh/$key_name
ssh-add ~/.ssh/$key_name
pub=`cat ~/.ssh/$key_name.pub`
read -p "Enter github username: " githubuser
echo "Using username $githubuser"
read -s -p "Enter github password for user $githubuser: " githubpass
echo
read -p "Enter personal access token: " token
read -p "Enter the title for your SSH key on GitHub: " title
curl --silent --output /dev/null --show-error --fail -u "$githubuser:$githubpass" -X POST -d "{\"title\":\"$title\",\"key\":\"$pub\"}" --header "Authorization: token $token" https://api.github.com/user/keys
echo "SSH key $key_name added for GitHub user $githubuser as $title"

# install Homebrew
echo "Installing Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Homebrew successfully installed!"

# update Homebrew
echo "Updating Homebrew..."
brew update
echo "Homebrew updated!"

# install xcode dev tools
echo "Installing Xcode developer CLI tools..."
xcode-select --install
echo "Xcode tools successfully installed!"

# clone dotfiles
cd ~
echo "Cloning dotfiles..."
git clone git@github.com:famazak/dotfiles.git
echo "Dotfiles cloned into ~/dotfiles"

# use stow to symlink dotfiles
cd ~/dotfiles
stow git
stow zsh
stow vim
stow taskwarrior

# install homebrew packages
echo "Installing Brew packages..."
brew bundle install --file=~/dotfiles/Brewfile

# use Homebrew installed zsh
chsh -s /usr/local/bin/zsh

# install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install oh my zsh plugins
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# install AWS CLI
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

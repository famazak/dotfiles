# ######################################
# Git and Github initial setup
# ######################################
git config --global user.name famazak
git config --global user.email zakfama58@gmail.com

read -p "Enter Github email: " email
echo "#### Using email: $email"

echo "#### Generating SSH key for Github..."
ssh-keygen -t ed25519 -C "$email"

echo "#### Starting SSH agent in the background"
eval "$(ssh-agent -s)"

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
if [ ! -e ~/.ssh/config] ; then
    echo "#### SSH config file not found, creating..."
    touch ~/.ssh/config
fi
echo -e "Host *\n   AddKeysToAgent yes\n    IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config

ssh-add -K ~/.ssh/id_ed25519
echo "#### Copying SSH public key to clipboard..."
pbcopy < ~/.ssh/id_ed25519.pub
echo "#### Finish up on Github.com"
read -p "Press [ENTER] to continue when done on Github..."

# ######################################
# Clone le dotfiles
# ######################################
cd ~
echo "#### Cloning dotfiles..."
git clone git@github.com:famazak/dotfiles.git
echo "#### Dotfiles cloned into ~/dotfiles"

# ######################################
# Setup Homebrew
# ######################################
command -v brew >/dev/null 2>&1 || { echo "#### Installing Homebrew.."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  } >&2;
echo "#### Homebrew successfully installed"

echo "#### Updating Homebrew..."
brew update
echo "#### Homebrew successfully updated!"

echo "#### Using Brewfile to install Homebrew packages..."
brew bundle install --file~/dotfiles/Brewfile
echo "#### Brewfile packages successfully installed"

# ######################################
# Install Oh My ZSH and plugins
# ######################################
echo "#### Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "#### Oh My ZSH installed"

echo "#### Installing ZSH plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "#### ZSH plugins installed"

## Fix zsh permissions
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

# ######################################
# Symlink dotfiles with stow
# ######################################
echo "#### Stowing..."
stow -d ~/dotfiles -R -t ~ -S git nano zsh
echo "#### Stowed"

source ~/.zshrc

# ######################################
# Install dbt auto-completion script
# ######################################
echo "#### Installing dbt autocompletion script..."
curl https://raw.githubusercontent.com/fishtown-analytics/dbt-completion.bash/master/dbt-completion.bash > ~/.dbt-completion.bash
echo "#### dbt autocompletion script installed"

# ######################################
# Setup global gitignore
# ######################################
echo "#### Creating global gitignore..."
touch ~/.gitignore
echo '.DS_Store' >> ~/.gitignore
echo '.idea' >> ~/.gitignore
echo "Global gitignore created"

# ######################################
# Mac preferences
# ######################################

# dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock minimize-to-application -bool true

# tap to click
defaults write com.apple.AppleMultitouchTrackpad Click -bool true
sudo default write com.apple.driver.AppleBluetoothMultitouch.trackpad Click -bool true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# TODO: Finder
defaults write com.apple.Finder FXPreferredViewStyle clmv

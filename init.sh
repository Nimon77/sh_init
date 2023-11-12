#!/bin/bash

sudo apt update
sudo apt install git gnupg zsh

git config --global user.signingkey 34DEB31EBA5CC362
git config --global user.name nimon
git config --global user.email nimon@42paris.fr

echo '# https://github.com/drduh/config/blob/master/gpg-agent.conf
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
enable-ssh-support
ttyname $GPG_TTY
default-cache-ttl 60
max-cache-ttl 120
pinentry-program /usr/bin/pinentry-curses
#pinentry-program /usr/bin/pinentry-tty
#pinentry-program /usr/bin/pinentry-gtk-2
#pinentry-program /usr/bin/pinentry-x11
#pinentry-program /usr/local/bin/pinentry-curses
#pinentry-program /usr/local/bin/pinentry-mac
#pinentry-program /opt/homebrew/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf

echo 'export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye > /dev/null' >> ~/.bashrc

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting'
sh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions'
echo 'source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

echo 'export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye > /dev/null' >> ~/.zshrc

zsh -c 'git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt" --depth=1'
zsh -c 'ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"'
sed -i -e "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"spaceship\"/g" ~/.zshrc

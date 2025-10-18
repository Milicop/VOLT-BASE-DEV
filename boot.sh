#!/bin/bash

ansi_art='
██╗   ██╗ ██████╗ ██╗  ████████╗
██║   ██║██╔═══██╗██║  ╚══██╔══╝
██║   ██║██║   ██║██║     ██║   
╚██╗ ██╔╝██║   ██║██║     ██║   
 ╚████╔╝ ╚██████╔╝███████╗██║   
  ╚═══╝   ╚═════╝ ╚══════╝╚═╝   
                                 
⚡ Powered by Ractor Package Manager
React Apps at Lightning Speed
'

clear
echo -e "\n$ansi_art\n"

pacman-key --init
pacman -Syu --noconfirm --needed sudo
sudo pacman -Syu --noconfirm --needed wget
sudo pacman -Syu --noconfirm --needed git
sudo pacman -Syu --noconfirm --needed node
sudo pacman -Syu --noconfirm --needed npm
sudo pacman -Syu --noconfirm --needed jq
# Install ractor package manager
wget https://raw.githubusercontent.com/CyberHuman-bot/Ractor/refs/heads/main/ractor.sh
chmod +x ractor.sh
sudo mv ractor.sh /usr/local/bin/ractor

# Use custom repo if specified, otherwise default to Milicop/Volt
VOLT_REPO="${VOLT_REPO:-Milicop/Volt}"

echo -e "\n⚡ Cloning Volt from: https://github.com/${VOLT_REPO}.git"
rm -rf ~/.local/share/volt/
git clone "https://github.com/${VOLT_REPO}.git" ~/.local/share/volt >/dev/null

# Use custom branch if instructed, otherwise default to master
VOLT_REF="${VOLT_REF:-master}"
if [[ $VOLT_REF != "master" ]]; then
  echo -e "\e[32m⚡ Using branch: $VOLT_REF\e[0m"
  cd ~/.local/share/volt
  git fetch origin "${VOLT_REF}" && git checkout "${VOLT_REF}"
  cd -
fi

echo -e "\n⚡ Installation starting..."
source ~/.local/share/volt/install.sh

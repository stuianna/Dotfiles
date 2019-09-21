#!/bin/bash

### Preparing the System
sudo pacman -Syu --noconfirm									                                    # Full system upgrade


### Inital package installation
sudo pacman -S yay --noconfirm									                                    # Package manager for AUR
yay -S --noconfirm --sudoloop \
git 												                                                `# Git` \
base-devel 											                                                `# Build packages` \
pulseaudio-alsa                                                                                     `# For audio` \
pulseaudio-bluetooth                                                                                `# For audio` \
pasystray                                                                                           `# For audio tray` \
dotfiles 											                                                `# To organise dotfiles` \
polybar 											                                                `# Updated status bar` \
xfce4-clipman-plugin 								                                                `# For image copy paste` \
feh 											                                                    `# For background image` \
st 											                                                        `# Prefered terminal` \
xdotool 											                                                `# Automated key presses` \
brave-bin												                                            `# Web browser` \
mediainfo 											                                                `# Information on multimedia files` \
atool												                                                `# Tool for working with all archive types` \
transmission-qt 										                                            `# Torrent GUI manager` \
transmission-cli 										                                            `# Torrent CLI manager` \
odt2txt 											                                                `# Tool for converting from open office format to text` \
poppler 											                                                `# PDF rendering library` \
openssh  											                                                `# For SSH` \
udiskie  											                                                `# For automounting of removable media` \
deepin-screenshot 										                                            `# Screenshot tool` \
unzip 												                                                `# For zip files` \
p7zip  												                                                `# For zip files` \
dropbox 											                                                `# Dropbox` \
unclutter  											                                                `# Hide the mouse when ile` \
zathura  											                                                `# PDF viewer` \
zathura-pdf-poppler 										                                        `# PDF viewer addon` \
pinta 												                                                `# Image editor` \
fuse-exfat 											                                                `# For FAT file systems` \
exfat-utils  											                                            `# For Fat file systems` \
virtualbox 											                                                `# Virtualbox` \
virtualbox-guest-iso 										                                        `# Virtualbox guest additions` \
evince 												                                                `# Fuller featured PDF viewer` \
gedit  												                                                `# Simple text editor` \
caffeine-ng 											                                            `# For preventing PC sleep` \
sshfs  												                                                `# For mounting file systems over ssh` \
libreoffice-fresh  										                                            `# Libreoffice suite` \
calcurse 											                                                `# Terminal based calendar application` \
pdfarranger 											                                            `# For edditing PDF document page orders` \
geoip  												                                                `# Determining the GEO location of an IP address` \
mdadm  												                                                `# For configuring raid` \
samba  												                                                `# Protocol for interfacing with network filesystems` \
vlc 												                                                `# Media player` \
xorg-xprop											                                                `# For getting window properties on click` \
cherrytree 											                                                `# Note taking application` \
python-pywal  											                                            `# For setting colour schemes globally` \
sqlitebrowser  											                                            `# For browsing sqlite databases` \
battop												                                                `# For viewing battery info` \
texlive-most 											                                            `# Tex fonts and config` \
mendeleydesktop-bundled 									                                        `# Research article and reference organizer` \
coin-or 											                                                `# Optimisation packages` \
drawio-desktop 											                                            `# Flowchart graphical package` \
spotify 											                                                `# Music streaming service` \
jupyter-notebook 										                                            `# Python web based editor` \
python-numpy 											                                            `# Python numeric toolkit` \
python-matplotlib 										                                            `# Python plotting library` \
python-pulp 											                                            `# Python optimisation kit` \
pyinstaller  											                                            `# Python executable generator` \
python-pyqt5  											                                            `# Python QT based GUI development` \
python-dash 											                                            `# Python web based development` \
python-dash-core-components 									                                    `# Python Dash Libs` \
python-scipy 											                                            `# Python for scientific computing` \
python-grip 											                                            `# View markdown files in webbrowser` \
python-bottle 											                                            `# Python web microframework` \
python-pycrypto 										                                            `# Python kit for encrypting strings` \
eagle  												                                                `# PCB design software` \
qtcreator 											                                                `# For C++ GUI development` \
openocd 											                                                `# On-chip debugger for MCU` \
arm-none-eabi-gdb 										                                            `# ARM cross compilation` \
arm-none-eabi-gcc 										                                            `# ARM cross compilation` \
arm-none-eabi-binutils 										                                        `# ARM cross compilation` \
arm-none-eabi-newlib 										                                        `# ARM cross compilation` \
ttf-font-awesome-4 										                                            `# Fonts for icons` \
ttf-font-awesome 										                                            `# Fonts for icons` \
arm-none-eabi-newlib 										                                        `# ARM cross compilation` \
brightnessctl 										                                                `# For brightness control` \
bluez 										                                                        `# Bluetooth library` \
skype 										                                                        `# Skype` \
npm 										                                                        `# npm package manager` \
stm32cubemx 										                                                `# stm32 cube for makefile generation` \
steam           										                                            `# game service`


## Unknown if needed open-vpn-systemd-resolved


### Get Dotfiles
rm -rf ~/Dotfile
git clone https://github.com/stuianna/Dotfiles.git ~/Dotfiles                                       # Get repository
rm -rf ~/.i3	 										                                            # Remove existing i3 config
dotfiles -fs											                                                # Sync dotfiles

### Configuration 
sed -i 's/export EDITOR.*/export EDITOR\=\/usr\/bin\/vim/' ~/.profile		                        # Change default editor to Vim
sed -i 's/export BROWSER.*/export BROWSER\=\/usr\/bin\/brave/' ~/.profile		                    # Change default browser to brave
mkdir -p ~/bin											                                            # Binary directory
echo 'export PATH=$PATH:~/Dotfiles/bin' >> ~/.profile						                        # Add Dotfiles bin directory to path
mkdir -p ~/.config/zathura									                                        # Make zathura config directory
ln -sf ~/.zathurarc ~/.config/zathura/zathurarc							                            # Link config file to ranger
sudo mkdir -p /run/media/stuart									                                    # Manually make media mounting directory
ln -s /run/media/stuart ~/media									                                    # Link manual and media directory shortcut
sudo cp ~/Dotfiles/Misc/sleeplock.service /etc/systemd/system/sleeplock.service	                    # Lock screen on sleep service
echo '(cat ~/.cache/wal/sequences &)' >> ~/.bashrc						                            # Make Wal work on new terminals
echo 'source ~/.profile' >> ~/.bashrc						                                        # source .profile from bashrc


### Services
sudo systemctl enable tlp-sleep.service								                                # Enable TLP (Power Management)
sudo systemctl start tlp-sleep.service								                                # Start TLP
sudo systemctl enable tlp.service								                                    # Enable TLP
sudo systemctl start tlp.service								                                    # Start TLP
sudo systemctl enable sshd									                                        # Enable ssh
sudo systemctl start sshd									                                        # Start ssh
sudo systemctl enable sleeplock.service								                                # Enable sleeplock

## Power management handling
#sudo sed -i 's/#HandleLidSwitch=suspend.*/HandleLidSwitch=suspend/' /etc/systemd/logind.conf	    # Suspend on lid close
#sudo sed -i 's/#HandlePowerKey=po.*/HandlePowerKey=poweroff/' /etc/systemd/logind.conf		        # Suspend on lid close

### VIM Setup
rm -rf ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim			            # Clone Repository
vim +PluginInstall +qall                                                                            # Install Vim plugins

wal -i ~/.wallpaper/old/boats_lake_scenery-wallpaper-2560x1440.jpg -a 85                            # Use Wal to set a color scheme
sudo chown stuart /run/media/stuart                                                                 # Change mount directory ownship for RW persmissions

### Additional libraries for embedded development
sudo npm install --global xpm                                                                       # Package manager for toolchain install
xpm install --global @gnu-mcu-eclipse/arm-none-eabi-gcc                                             # Arm toolchain for eclipse

### Setup permissions for STLink
echo 'ATTRS{idVendor}=="0483",ATTRS{idProduct}=="3748",MODE="0666"' | sudo tee -a /etc/udev/rules.d/99-stlink.rules
sudo udevadm control --reload-rules
sudo gpasswd -a stuart uucp

### MISC
# Dropbox doesn't work at the moment, need to change permission of file:
#sudo chmod 755 /opt/dropbox/libdropbox_apex.so

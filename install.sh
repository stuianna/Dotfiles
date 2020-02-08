
LOCATION=HOME

set -uo pipefail
trap 's=$?; echo "$@: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

FAILED=''
function install_package {
	# Only install package if not already installed, append to errors if package can't be installed
	if yay -Qs $1 > /dev/null; then 
		return; 
	else
		if echo $1 | xargs yay -S --noconfirm --sudoloop ; then
			:
		else
			FAILED+="$1 "
		fi
	fi
}

function cleanup {
	if [ "$FAILED" != '' ]; then
		echo "The following packages couldn't be installed: $FAILED"
	else
		:
	fi
}

function add_config {
# Argments are 'configuration line', 'file'
	if grep "$1" $2 > /dev/null; then
		:
	else
		echo "$1" >> $2
	fi
}

function configure_environment {
	add_config "source .profile" ~/.bashrc
	add_config "export EDITOR=/usr/bin/vim" ~/.profile																									# Set editor
	add_config "export BROWSER=/usr/bin/brave" ~/.profile																							# Set browser
	add_config "export LOCATION='$LOCATION'" ~/.profile																								# Set device location
	add_config 'export PATH=$PATH:~/Dotfiles/bin' ~/.profile						                   							# Add repo binary to path
	add_config 'export QT_QPA_PLATFORMTHEME=qt5ct' ~/.profile						                   							# Set qt theme 
	add_config 'PATH=$PATH:~/bin' ~/.bashrc						                                        				# add ~/bin to path
	add_config 'source /usr/share/fzf/key-bindings.bash' ~/.bashrc																			# Fuzzy finder hotkeys
	add_config 'source /usr/share/fzf/completion.bash' ~/.bashrc																				# Fuzzy finder hotkeys
	add_config 'complete -o bashdefault -o default -F _fzf_path_completion zathura' ~/.bashrc					# Fuzzy finder for pdf
	add_config '(cat ~/.cache/wal/sequences &)' ~/.bashrc						                            			# Make Wal work on new terminals
	
	add_config 'powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/share/powerline/bindings/bash/powerline.sh'  ~/.bashrc						                     	# Powerline fonts configuration

	add_config 'if [ "$LOCATION" == "HOME" ]
	then
		cat ~/.i3/config_base ~/.i3/config_home > ~/.i3/config
	elif [ "$LOCATION" == "WORK" ]
	then
		cat ~/.i3/config_base ~/.i3/config_work > ~/.i3/config
	fi'  ~/.profile																																								# Switch between home and work profiles

	sudo cp ~/Dotfiles/Misc/xorg.conf /etc/X11/
	sudo chown stuart /run/media/stuart                                                            	# Change mount directory ownship for RW persmissions
	wal -i ~/.wallpaper/old/boats_lake_scenery-wallpaper-2560x1440.jpg                             	# Use Wal to set a color scheme
	mkdir -p ~/bin																																									# Make a directory for binaries
	mkdir -p ~/.config/termite									                                        						# Make termite config directory
	ln -sf ~/.termite/config	~/.config/termite/config																											# Link dotfiles stored config to termite's search location
	mkdir -p ~/.config/zathura									                                        						# Make zathura config directory
	ln -sf ~/.zathurarc ~/.config/zathura/zathurarc							                            				# Link config file to zathura
	ln -sf ~/.ranger/rc.conf ~/.config/ranger/rc.conf						                            				# Link config file to ranger
	sudo mkdir -p /run/media/stuart									                                    						# Manually make media mounting directory
	ln -sf /run/media/stuart ~/media									                                    						# Link manual and media directory shortcut
	sudo cp ~/Dotfiles/Misc/sleeplock.service /etc/systemd/system/sleeplock.service	                # Lock screen on sleep service
}

function install_initial {

	sudo pacman -Syu --noconfirm
	if pacman -Qs yay > /dev/null; then 
		:
	else
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si --noconfirm
		cd ../
		rmdir -rf yay
	fi
	install_package "xorg-server"							# To organise dotfiles
	install_package "xorg-xinit"							# To organise dotfiles
	install_package "i3-gaps"							# To organise dotfiles
	install_package "i3status"							# To organise dotfiles
	install_package "termite"							# To organise dotfiles
	install_package "dmenu"							# To organise dotfiles
	install_package "vim"							# To organise dotfiles
	install_package "vi"							# To organise dotfiles
	install_package "dotfiles"							# To organise dotfiles
	install_package "dialog"							# Get user input in terminal

	if ls ~/Dotfiles 2> /dev/null; then
		:
	else
		git clone https://github.com/stuianna/Dotfiles.git
		cd Dotfiles
		git checkout newarch
		cd ../
		dotfiles -s
	fi
}

function install_inpiron {
	install_package "wd719x-firmware"
	install_package "aic94xx-firmware"
}

function enable_services {

	sudo systemctl enable tlp.service								                                					# Enable TLP (Power Management)
	sudo systemctl start tlp.service								                                					# Start TLP
	sudo systemctl enable sshd									                                        						# Enable ssh
	sudo systemctl start sshd									                                        							# Start ssh
	sudo systemctl enable sleeplock.service								                                					# Enable sleeplock
	sudo systemctl enable lightdm.service																														# Login screen
}

function configure_vim {
	rm -rf ~/.vim																																									 	# Remove any exiting configuration
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim			           	# Clone Repository
	vim +PluginInstall +qall                                                                       	# Install Vim plugins
}

function install_audio {
	install_package "pulseaudio-alsa"										# For audio
	install_package "pulseaudio-bluetooth"							# For audio
	install_package "pasystray"							# For audio tray
}

function install_environment {

	install_package "dotfiles"							# To organise dotfiles
	install_package "polybar"							# Updated status bar
	install_package "ranger"							# File browser
	install_package "feh"							# For background image
	install_package "brave-bin"							# Web browser
	install_package "deepin-screenshot"							# Screenshot tool
	install_package "termite"							# Terminal emulator (current
	install_package "unclutter"							# Hide the mouse when ile
	install_package "caffeine-ng"							# For preventing PC sleep
	install_package "vlc"							# Media player
	install_package "python-pywal"							# For setting colour schemes globally
	install_package "ttf-font-awesome-4"							# Fonts for icons
	install_package "ttf-font-awesome"							# Fonts for icons
	install_package "ttf-inconsolata"							# Fonts for icons
	install_package "ttf-indic-otf"							# Fonts for icons
	install_package "nerd-fonts-complete"							# Fonts for icons
	install_package "font-manager"							# Graphical font manager
	install_package "bluez"							# Bluetooth library
	install_package "bluez-utils"							# Bluetooth library utilites
	install_package "galculator"							# GTK calculator
	install_package "powerline"							# Powerline font server
	install_package "powerline-fonts-git"							# Patched fonts
	install_package "awesome-terminal-fonts"							# Terminal fonts
	install_package "terminus-font"							# More fonts
	install_package "viewnior"							# Image viewwer
	install_package "network-manager-applet"							# Network manager taskbar
	install_package "networkmanager-openvpn"							# Network manage openvpn stuff
	install_package "lightdm"							# Login screen
	install_package "lightdm-gtk-greeter"							# Login screen
	install_package "dolphin"							# Graphical file manager
	install_package "clipit"							# Clipboard manager
	install_package "arandr"							# Graphical front end for xradr
	install_package "arc-gtk-theme"				# Gtk themes use lxappearance to modify
	install_package "compton"				# Compton
	install_package "arc-icon-theme"				# Gtk icon use lxappearance to modify
	install_package "i3lock"				# Gtk icon use lxappearance to modify
}

function install_utilities {

	install_package "xfce4-clipman-plugin"							# For image copy paste
	install_package "htop"							# Graphical TOP
	install_package "xfce4-power-manager"							# Power management
	install_package "xdotool"							# Automated key presses
	install_package "mediainfo"							# Information on multimedia files
	install_package "atool"							# Tool for working with all archive types
	install_package "transmission-qt"							# Torrent GUI manager
	install_package "transmission-cli"							# Torrent CLI manager
	install_package "unzip"							# For zip files
	install_package "p7zip"							# For zip files
	install_package "zip"							# For zip files
	install_package "dropbox"							# Dropbox
	install_package "fuse-exfat"							# For FAT file systems
	install_package "exfat-utils"							# For Fat file systems
	install_package "geoip"							# Determining the GEO location of an IP address
	install_package "xorg-xprop"							# For getting window properties on click
	install_package "battop"							# For viewing battery info
	install_package "sqlitebrowser"							# For browsing sqlite databases
	install_package "python-grip"							# View markdown files in webbrowser
	install_package "inotify-tools"							# Perform events on file updates
	install_package "ripgrep"							# Fast tool for line searching file, used in VIM
	install_package "openssh"							# For SSH
	install_package "sshfs"							# For mounting file systems over ssh
	install_package "xorg-xrandr"							# monitor config
	install_package "tlp"							# Power management
	install_package "fzf"							# Fuzzy search tool
	install_package "udiskie"							# For automounting of removable media
	install_package "xautolock"							# Automatic screen locking
	install_package "xarchiver"							# Front end for archive files.
	install_package "tree"							# Terminal tree diagrams
	install_package "speedtest-cli"							# Internet speed test (CLI)
	install_package "snapd"							# Package manager for snap packages
	install_package "screenfetch"							# terminal system information
	install_package "rsync"							# Copy files to network destinations
	install_package "qt5ct"							# QT environment selector (TODO errors)
	install_package "qt5-styleplugins"							# QT environment selector
	install_package "powertop"							# Power usage analysis
	install_package "perl-file-mimeinfo"							# Provide information on file-types
	install_package "ntp"							# Network time protocol
	install_package "ntfs-3g"							# Read and write support for ntfs file systems
	install_package "ncdu"							# Disk usage analyizer
	install_package "ngrok"							# Tunnel local port to remote
	install_package "lxinput"							# Small program for keyboard and mouse settings
	install_package "lxappearance"							# Small program themeing (TODO errors)
	install_package "gvfs-mtp"							# For MTP (Android) file systems
	install_package "gvfs-smb"							# For windows file systems
	install_package "gvfs-gphoto2"							# For android file photos
	install_package "gvfs-afc"							# For apple file systems
	install_package "gparted"							# For apple file systems
	install_package "downgrade"							# Tool for downgrading packages
	install_package "universal-ctags"							# Source code tag system for vim
	install_package "cpulimit"							# Limit CPU usage for processes
	install_package "kvantum-qt5"							# QT5 theme
	install_package "man"							# Manual pages

}

function install_maybe {

	install_package "matcha-gtk-theme"							# GTK theme

}

function install_thinkpad {

	install_package "tp_smapi-dkms"							# Kernal bus communication
	install_package "tpapci-bat"							# Kernal bus communication (Battery)
	install_package "linux-intel-undervolt-tool"							# Undervolt tools
	install_package "intel-undervolt"							# Undervolt tools


}

function install_intel {

	install_package "vulkan-intel"							# Mesa drivers for intel
}

function install_amd {

	install_package "vulkan-radeon"							# Mesa drivers for AMD
}

function install_pcb {

	install_package "eagle"							# PCB design software
	install_package "ltspice"							# Electrical simulation software
}

function install_virtualbox {

	install_package "virtualbox"							# Virtualbox
	install_package "virtualbox-guest-iso"							# Virtualbox guest additions
}

function install_latex {

	install_package "texlive-most"							# Tex fonts and config
	install_package "mendeleydesktop-bundled"							# Research article and reference organizer
}

function install_python {

	install_package "jupyter-notebook"							# Python web based editor
	install_package "python-numpy"							# Python numeric toolkit
	install_package "python-matplotlib"							# Python plotting library
	install_package "pyinstaller"							# Python executable generator
	install_package "python-pyqt5"							# Python QT based GUI development
	install_package "python-dash"							# Python web based development
	install_package "python-dash-core-components"							Python Dash Libs
	install_package "python-scipy"							# Python for scientific computing
	install_package "python-bottle"							# Python web microframework
	install_package "python-pycrypto"							# Python kit for encrypting strings
}

function install_optimisation {

	install_package "python-pulp"							# Python optimisation kit
	install_package "coin-or"							# Optimisation packages
}

function install_documents {

	install_package "odt2txt"							# Tool for converting from open office format to text
	install_package "poppler"							# PDF rendering library
	install_package "zathura"							# PDF viewer
	install_package "zathura-pdf-poppler"							# PDF viewer addon
	install_package "pinta"							# Image editor
	install_package "evince"							# Fuller featured PDF viewer
	install_package "gedit"							# Simple text editor
	install_package "pdfarranger"							# For edditing PDF document page orders
	install_package "cherrytree"							# Note taking application
	install_package "drawio-desktop"							# Flowchart graphical package
}

function install_other {

	install_package "skypeforlinux"							# Skype
	install_package "steam"							# game 
	install_package "spotify"							# Music streaming service
}

function install_32Bit {

	install_package "lib32-vulkan-radeon"			# AMD drivers
	install_package "lib32-vulkan-intel"			# Intel drivers
	install_package "lib32-openal"			# 
	install_package "lib32-flex"			# 
	install_package "lib32-libpulse"			# 
	install_package "lib32-libva-vdpau-driver"			# 
	install_package "lib32-mesa-demos"			# 
	install_package "lib32-mesa-vdpau"			# 

}


function install_work {

	install_package "otii"							# Power supply / analyser software (for work
	install_package "gqrx"							# RF analyser graphical interface
}

function install_dev {

	install_package "cmake"							# Build system for cross platform make
	install_package "qtcreator"							# For C++ GUI development
	install_package "openocd"							# On-chip debugger for MCU
	install_package "eclipse"							# Eclipse
	install_package "arm-none-eabi-gdb"							# ARM cross compilation
	install_package "arm-none-eabi-binutils"							# ARM cross compilation
	install_package "arm-none-eabi-newlib"							# ARM cross compilation
	install_package "doxygen"							# Document generation from source code
	install_package "npm"							# npm package manager
	install_package "stm32cubemx"							# stm32 cube for makefile generation
	install_package "sublime-merge"							# Git commit and GUI tool
	install_package "graphviz"							# Packages for drawing graphs in Dot language (doxygen
	install_package "cutecom"							# Serial terminal interface
	install_package "valgrind"							# Check programs for memeory leaks
	install_package "python-intexhex"							# Check programs for memeory leaks
}

function install_wine {

	install_package "lib32-libpulse"							# Sound for wine
	install_package "lib32-openal"							# Sound for wine
}

HOST_NAME=''
USER_NAME=''
USER_PASS=''
ROOT_PASS=''
PC_LOCATION=''
REGION=''
CITY=''
DEVICE=''

if [ $# == 0 ]; then
	echo "Valid argments 'initial'"
	echo "Valid argments 'setup'"
	exit
else
	:
fi

if [ "$1" == "initial" ]; then
	echo "Before running, disks should be formatted and mounted correctly ( to /mnt.. ). Mirrors should be selected from /etc/pacman.d/mirrorlist"
	echo "OK? (y/n)"
	read -s reply
	[[ "$reply" == "y" ]] || (echo "Exiting"; exit;)
	HOST_NAME=$(dialog --stdout --inputbox "Enter hostname" 0 0) || exit 1 : ${HOST_NAME:?"Hostname cannot be empty"}
	USER_NAME=$(dialog --stdout --inputbox "Enter username" 0 0) || exit 1 : ${USER_NAME:?"Username cannot be empty"}
	PC_LOCATION=$(dialog --stdout --inputbox "Enter pc location (WORK/HOME)" 0 0) || exit 1 : ${PC_LOCATION:?"Location cannot be empty"}
	REGION=$(dialog --stdout --inputbox "Enter region (Europe/Australia)" 0 0) || exit 1 : ${REGION:?"Region cannot be empty"}
	CITY=$(dialog --stdout --inputbox "Enter city (Riga/Sydney)" 0 0) || exit 1 : ${CITY:?"City cannot be empty"}
	USER_PASS=$(dialog --stdout --passwordbox "Enter user password" 0 0) || exit 1 : ${USER_PASS:?"User password cannot be empty"}
	ROOT_PASS=$(dialog --stdout --passwordbox "Enter root password" 0 0) || exit 1 : ${ROOT_PASS:?"Root password cannot be empty"}
	pacstrap /mnt base linux linux-firmware networkmanager amd-ucode intel-ucode base-devel grub efibootmgr vim wget git
	genfstab -u /mnt >> /mnt/etc/fstab
	echo "${HOST_NAME}" >> /mnt/etc/hostname
	arch-chroot /mnt useradd -mU -g wheel "${USER_NAME}"
	echo "$USER_NAME:$USER_PASS" | chpasswd --root /mnt
	echo "root:$ROOT_PASS" | chpasswd --root /mnt
	ln -sf /mnt/usr/share/zoneinfo/${REGION}/${CITY} /mnt/etc/localtime
	arch-chroot /mnt hwclock --systohc
	sed -i "s/#en_AU.UTF-8 UTF-8/en_AU.UTF-8 UTF-8/" /mnt/etc/locale.gen
	sed -i "s/#lv_LV.UTF-8 UTF-8/lv_LV.UTF-8 UTF-8/" /mnt/etc/locale.gen
	arch-chroot /mnt locale-gen
	echo "LANG=en_AU.UTF-8" > /mnt/etc/locale.conf
	echo "127.0.0.1    localhost" >> /mnt/etc/hosts
	echo "::1    			 localhost" >> /mnt/etc/hosts
	arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=efi --bootloader-id=GRUB
	arch-chroot /mnt grub-mkconfig -o /mnt/boot/grub/grub.cfg
	arch-chroot /mnt systemctl enable NetworkManager
	sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /mnt/etc/sudoers
	cp install.sh /mnt/home/${USER_NAME}/install.sh
	chmod +x /mnt/home/${USER_NAME}/install.sh
	echo "Done, exit and reboot, login as new user and run install.sh 'setup'"
	exit
else
	LOCATION=$(dialog --stdout --inputbox "Enter pc location (WORK/HOME)" 0 0) || exit 1 : ${PC_LOCATION:?"Location cannot be empty"}
fi

install_initial
install_audio
install_environment
install_utilities
install_documents
enable_services
configure_environment
configure_vim
cleanup



# Arch Linux Install

## Installing OS

This is an EFI install, so need to boot from EFI, not Legacy 
1. Verify boot mode
```
# ls /sys/firmware/efi/efivars
```
2. Connect and check internet
```
wifi-menu
ping www.google.com
```
3. Sync system clock
```
timedatectl set-ntp true
```
4. Disk partitioning
```
fdisk -l
```
 - Delete all partitions
 - Create boot partition, type EFI, size +550M (sda1)
 - Create swap partition, size +1x RAM (sda2)
 - Create root partition, size +10-25G (sda3)
 - Create home partition, remaining size (sda4)

5. Make file systems
```
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
swapon /dev/...
```
6. Mount the partitions, order is important, root partition first
```
mount /dev/sda3 /mnt
mkdir /mnt/efi
mkdir mnt/home
mount /dev/sda1 /mnt/efi
mount /dev/sda4 /mnt/home
```
7. Install arch, development pack and vim
```
pacstrap /mnt base base-devel vim
```
8. make file system table definitions
```
genfstab -U /mnt >> /mnt/etc/fstab
```
Check fstab to make sure all partitions are there

9. Change into new system
```
arch-chroot /mnt
```
10. Set the time zone
```
ln -sf /usr/share/zoneinfo/Australia/Brisbane /etc/localtime
```
11. Set hardware clock
```
hwclock --systohc
```
12. Uncomment regional settings, en_AU.UTF-8 and en_AU ISO-8859-1 in
```
/etc/locale.gen
```
13. Generate locals
```
locale-gen
```
14. Set lang variable 
```
/etc/locale.conf
LANG=en_AU.UTF-8
```
15. Set hostname
```
/etc/hostname
myhostname
```
16. Set password
```
passwd
```
17. Install [Microcode](https://wiki.archlinux.org/index.php/Microcod3) for CPU archetecture
AMD
```
pacman -S amd-ucode
```
Intel
```
pacman -S intel-ucode
```
18. Install grub package and boot manager
```
pacman -S grub efibootmgr
```
19. Install grub
```
grub-install --target=x86_64-efi --efi-directory=efi --bootloader-id=GRUB
```
20. Configure grub
```
grub-mkconfig -o /boot/grub/grub.cfg
```
21. Install network manager and acitvate it
```
pacman -S networkmanager
systemctl enable NetworkManager
```
24. Done, restart
```
exit
reboot
```
## Inital configuration

Initial login name: root, password: ...

1. Create a user account
```
useradd -m -g wheel 'newusername'
```
2. Set user password
```
passwd 'newusername'
```
3. Modify sudo access so user can access root
```
visudo
```
Uncomment the line
```
%wheel ALL=(ALL) ALL
```
Optionally, some programs can be added so they don't need a password to run
```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/mount,/usr/bin/umount
```
4. Connect to the internet
Search for networks
```
nmcli device wifi list
```
Connect to network
```
nmcli device wifi connect SSID password password
```
[wiki](https://wiki.archlinux.org/index.php/NetworkManager) For information


5. Install X for the graphical environment
```
pacman -S xorg-server xorg-xinit
```
6. Install I3
```
pacman -S i3-gaps i3status rxvt-unicode dmenu 
```
7. Install fonts using [these](https://www.reddit.com/r/archlinux/comments/5r5ep8/make_your_arch_fonts_beautiful_easily/) Instructions

8. Set X to start I3 when started
```
~/.xinitrc
exec i3
```
Now i3 can be started from tty with startx,  Logout of root and login to new user account

## Program Configuration / Installation

1. Install Git and clone this repository
```
sudo pacman -S git
git clone ...
```

2. Install Yay

```
git clone https://aur.archlinux.org/yay.git
cd st
makepkg -si
```
3. Basic Programs
```
yay -S st ranger ffmpegthumbnailer highlight libcaca mediainfo atool transmission-cli odt2txt poppler openssh udiskie network-manager-applet deepin-screenshot compton feh unzip p7zip polybar dropbox alsa-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth pasystray spotify playerctl dotfiles shotwell unclutter conky zathura zathura-pdf-poppler chromium mimeo xdg-utils-mimeo i3lock-wrapper wget zip bluez bluez-utils blueman-applet brightnessctl mons htop tree tlp pinta openvpn openvpn-update-systemd-resolved fuse-exfat exfat-utils virtualbox-host-modules-arch virtualbox virtualbox-guest-iso w3m evince caffeine-ng xautolock nmap sshfs xdotool translate-shell libreoffice-fresh calcure transmission-qt pdfarranger geoip nmap

```
4. Academic
```
yay -S texlive-most mendeleydesktop-bundled webplotdigitizer-bin coin-or drawio-desktop
```
5. Development

Python - Don't use PIP
```
yay -S jupyter-notebook python-numpy python-matplotlib python-pulp eagle qtcreator pyinstaller python-pyqt5 tk python-dash python-dash-core-components python-scipy python-grip
```
From ~/bin folder
```
wget https://github.com/stuianna/vocabBuilder/releases/download/v0.2.0/vocabBuilder-cli
wget https://raw.githubusercontent.com/ekalinin/github-markdown-toc/master/gh-md-toc

```
### Configuration

Vim setup -> Vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Open vim and run ':PluginInstall'


Add a 'bin' directory for local scripts and binaries
```
mkdir ~/bin
```
Make a link to the media directory in the home directory. Only works after a removeable drive has been mounted at least once
```
ln -s /run/media/stuart ~/media
```

Edit ~/.bash_profile and add the following

```
export PATH=$PATH:$HOME/bin
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="chromium"
```
Sync dotfiles
```
dotfiles --sync
```

Zathura needs a simlink for its config file

```
ln -s ~/.zathurarc ~/.config/zathura/zathurarc
```
Brightness control (brightnessctl) needs to be added to visudo to work. Add / append to line, if appending, commands are seperated by commas.

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/brightnessctl
```

Mendely Desktop overrides PDF association, run: (Assuming zathura is already installed)
```
mimeo --add application/pdf org.pwmt.zathura.desktop
sudo mimeo --update
```
Enable tlp -> power manager
```
sudo systemctl enable tlp-sleep.service
sudo systemctl enable tlp.service
```

System sleep on lid, and lockscreen

Create a file name sleeplock.service in /etc/systemd/system with the following
```
[Unit]
Description=i3lock on suspend
Before=sleep.target

[Service]
User=<USERNAME>
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/i3lock-wrapper

[Install]
WantedBy=sleep.target
```
Enable the service
```
sudo systemctl enable sleeplock.service
```

VPN

Openvpn is used to interface with airvpn

First generate configuration files using the airvpn online config file generator, just one for planet earth for now

Enable the required services

```
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service
```

The downloaded configuration file needs to be modified at the end of the first section, before <ca> add:
```
script-security 2
up /etc/openvpn/scripts/update-systemd-resolved
down /etc/openvpn/scripts/update-systemd-resolved
```

Move the configuration file to the home directory, rename it to '.airvpn_config_all.ovpn'

Add the following to visudo, using a comma between commands if needed

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/openvpn
```

The vpn is initiated at login at in .i3/config

Disable PC Speaker (BEEP)

Disable the kernal module and prevent it from being reloaded
```
sudo rmmod pcspkr
sudo bash -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'
```
VIRTUAL MACHINE

Create a new directory forVm stuff, and shared folder

```
mkdir ~/_vm
mkdir ~/_vm/windown_shared
```

Create a new virtual machine, make vm location the created directory. Use existing win7.vdi image.

Install guest additions in the virtual machine and restart it.

In VirtualBox manager, set the shard directory to windown_shared, automount to E:

Change network adapter to bridged.

Change video adapter settings (64Mb ram, 2D accleration)

RANGER

generate the config file with 
```
ranger --copy-config=all
```
inside the config file ~/.config/ranger/rc.conf set the preview_images flag to true

SSH

Check sshd is running
```
ps aux | grep sshd
```
If it's not and still doesn't work, start and enable the service

```
sudo systemctl start sshd
sudo systemctl enable sshd
```

Check if it is listening on required port (22):
```
nmap -p 22 127.0.0.1
```

The default port and other things can be changed:
```
#/etc/ssh/sshd_config
Port 22
```


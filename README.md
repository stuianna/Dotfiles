
# Arch Linux Install

## Prereq Notes

- Need to boot into EFI mode.
- On some PCs / Laptops, 'nomodeset' may need to be added to boot by pressing 'e' in the GRUB menu and booting.

## Installing OS

### Initial Preperation

Verify boot mode, this should spit out a bunch of files, if not, reboot with EFI enabled.
```
# ls /sys/firmware/efi/efivars
```
Connect to the internet.
```
wifi-menu
ping www.google.com
```
Sync system clock
```
timedatectl set-ntp true
```
### Disk Setup

Determine the device name of the physical disk
```
fdisk -l
```
Launch `fdisk /dev/sdx` with the correct physical disk. Perform the following

 - 
 - Delete all partitions
 - Create boot partition, type EFI, size +550M (sda1)
 - Create swap partition, size +1x RAM (sda2)
 - Create root partition, size +15-50G (sda3)
 - Create home partition, remaining size (sda4)


Make file systems:
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
systumctl enable NetworkManager
```
24. Done, restart
```
exit
reboot
```
## Inital configuration

This part is reached after we can suscsessfully log into a new Arch install. The goal here is to install / configure just enough functionallity to boot into X (graphical interface) and install the main bunch of packages. The initial login name is root.

## Creating a new user.

Create a new user account, the default group to join in 'wheel'.

```
useradd -m -g wheel 'newusername'
```
Set a password for the new user:
```
passwd 'newusername'
```

### Escellating Privliges
Optionally, the user can be given user privilages. Run this command to modify sudoers.
```
visudo
```
Uncomment this line to allow all members of group 'wheel' to have optional (on password) root privliges.
```
%wheel ALL=(ALL) ALL
```
Optionally, some programs can be added so they don't need a password to run:
```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/mount,/usr/bin/umount
```

## Connecting to the Internet

Search for networks, SSID return is the name of the network:
```
nmcli device wifi list
```
Connect to network:
```
nmcli device wifi connect SSID password password
```
More information is available in the [wiki](https://wiki.archlinux.org/index.php/NetworkManager).

## Minimal Graphical Environment and I3WM

This minimal setup include 'git', 'firefox' and 'rxvt-unicode', which come in handy in the following steps.

```
pacman -S xorg-server xorg-xinit i3-gaps i3status rxvt-unicode dmenu firefox git
```

Now add I3 to xinit so it starts automatically with X.

```
# FILE: /home/'newusername'/.xinitrc

exec i3
```

Now logout of the root account:
```
logout
```

Log into new account which was just made and startx, to boot into graphical environment.
```
startx
```

When the I3WM config window appears, don't generate a config file, just use the defaults.

# Arch Packages

Once you can login and run X, the main set of packages are ready to be installed.


## Initial Requirements

These steps are required to be conducted first before the main chuck of packages can be installed.

### Yay Package Manager

Yay is a package manager which can access the AUR as well as normal Pacman commands.

```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rmdir -rf yay
```
### Dotfiles

Grab my dotfiles for instant configuration as well as usefull template. The final command syncs my dotfiles to their approprate places. Info on the dotfiles package can be found [here](https://github.com/jbernard/dotfiles).

```
yay -S dotfiles
git clone https://github.com/stuianna/Dotfiles.git
dotfiles -s
```

### Fonts - Pending

Install some fonts:

```
yay -S ttf-dejavu ttf-liberation noto-fonts
```

Enable fonts by creating symbolic links:
```
sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
```

Enable subpixel hinting mode by editing `/etc/profile.d/freetype2.sh` and uncommenting
```
export FREETYPE_PROPERTIES="truetype:interpreter-version=40"
```

For application consistent fonts create a new file in `/etc/fonts/local.conf`, with the following:
```
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
      <match>
          <edit mode="prepend" name="family"><string>Noto Sans</string></edit>
      </match>
      <match target="pattern">
          <test qual="any" name="family"><string>serif</string></test>
          <edit name="family" mode="assign" binding="same"><string>Noto Serif</string></edit>
      </match>
      <match target="pattern">
          <test qual="any" name="family"><string>sans-serif</string></test>
          <edit name="family" mode="assign" binding="same"><string>Noto Sans</string></edit>
      </match>
      <match target="pattern">
          <test qual="any" name="family"><string>monospace</string></test>
          <edit name="family" mode="assign" binding="same"><string>Noto Mono</string></edit>
      </match>
  </fontconfig>

```

These instructions were shamelessly stolen from [here](https://www.reddit.com/r/archlinux/comments/5r5ep8/make_your_arch_fonts_beautiful_easily/).

## Program installation.

The bulk of the packages get installed here.

### Everyday Packages

There are lot of packages here which I use for 'everyday use'. I simply add to this list as I see fit. This list usually takes at least an hour to get through.

```
yay -S --answerdiff N --noremovemake --sudoloop --answerclean N st ranger ffmpegthumbnailer highlight libcaca mediainfo atool transmission-cli odt2txt poppler openssh udiskie network-manager-applet deepin-screenshot compton feh unzip p7zip polybar dropbox alsa-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth pasystray spotify playerctl dotfiles shotwell unclutter conky zathura zathura-pdf-poppler chromium mimeo xdg-utils-mimeo i3lock-wrapper wget zip bluez bluez-utils brightnessctl mons htop tree tlp pinta openvpn openvpn-update-systemd-resolved fuse-exfat exfat-utils virtualbox-host-modules-arch virtualbox virtualbox-guest-iso w3m evince caffeine-ng xautolock nmap sshfs xdotool translate-shell libreoffice-fresh calcurse transmission-qt pdfarranger geoip nmap dnsutils networkmanager-openvpn mdadm samba vlc xorg-xprop cherrytree vim-anywhere otf-overpass python-pywal sqlitebrowser battop
```
### Academic Packages

These packages have more of an academic flavour:

```
yay -S texlive-most mendeleydesktop-bundled webplotdigitizer-bin coin-or drawio-desktop
```
### Development Packages

These packages have are more related to engineering / developement:

```
yay -S jupyter-notebook python-numpy python-matplotlib python-pulp eagle qtcreator pyinstaller python-pyqt5 tk python-dash python-dash-core-components python-scipy python-grip python-bottle python-bottle-cork python-pycrypto python-beaker python-scrypt
```
### Custom Scripts / Non-AUR Programs

These are programs or scripts which I or others have made which are not on the AUR. All these scripts will be available on path, if the directory is cloned into the home folder.

```
git clone https://github.com/stuianna/bin
```

### Blackarch

[Blackarch](https://blackarch.org/) is a distribution used for security and penetration testing. The packages can be added to standard Arch by adding an unofficial repository. There are heaps of tools, in total around 35G is needed to install them all. Due to the nature of the toolset, I like to keep this in a seperate Arch VM.

Wine needs to be installed before some of the Blackarch packages can be installed. Instructions for Wine are detailed lower in this document.

Up to date installation instructions for Blackarch can be found [here](https://blackarch.org/downloads.html#install-repo). The jist of the are:

```
# Run https://blackarch.org/strap.sh as root and follow the instructions.

$ curl -O https://blackarch.org/strap.sh
# The SHA1 sum should match: 9f770789df3b7803105e5fbc19212889674cd503 strap.sh 
# The SHA1 sum changes as strap.sh is modified, check above link for current sum.

$ sha1sum strap.sh
# Set execute bit

$ chmod +x strap.sh
# Run strap.sh

$ sudo ./strap.sh
```

Run a system upgrade
```
sudo pacman -Syyu
```

Tools from the repository can be found with:
```
# To list all of the available tools, run

$ sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u
# To install all of the tools, run

$ sudo pacman -S blackarch
# To install a category of tools, run

$ sudo pacman -S blackarch-<category>
# To see the blackarch categories, run

$ sudo pacman -Sg | grep blackarch
```

## Arch VM Guest

### Guest Additions

If the new machine is a Virtualbox guest, install guest additions from within the guest with:
```
sudo pacman -S virtualbox-guest-utils
```

Be sure to choose **virtualbox-guest-module-arch** or Arch will stop booting. If this happens, boot with the arch.iso, mount all partions and reinstall grub and the grub config.

### Compton Issues

Compton with the VM doesn't work well with OpenGl. In the config file `.compton/config` comment out the line:
```
#vsync = "opengl"; 
```

# Configuration

## Bash Profile and Default Programs

Edit `~/.bash_profile` and add the following, change progams and resolutions as need be.

```
export PATH=$PATH:$HOME/bin
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"
export RESOLUTION_V=1920
export RESOLUTION_H=1080
export RESOLUTION_TARGET="HDMI-0"
```
## Vim

Vundle is used as a package manager for Vim. Vimrc files were included with the dotfiles.

Clone the Vundle repository:

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Open vim and run `:PluginInstall` to install all plugins.

## Zathura

Zathura needs a simlink for its config file

```
ln -s ~/.zathurarc ~/.config/zathura/zathurarc
```

Mendely Desktop (academic listing) overrides PDF association, run: (Assuming zathura is already installed)
```
mimeo --add application/pdf org.pwmt.zathura.desktop
sudo mimeo --update
```

## Media Directory

A removeable drive (USB) needs to have been mounted at least once for this to work. This allows easy access mounted drives.

```
ln -s /run/media/stuart ~/media
```

### Brightness control

Brightness control (brightnessctl) needs to be added to visudo to work. Add / append to line, if appending, commands are seperated by commas.

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/brightnessctl
```

## Power Management

[Tlp](https://wiki.archlinux.org/index.php/TLP) should be already installed, just need to enable its services.

```
sudo systemctl enable tlp-sleep.service
sudo systemctl enable tlp.service
```

## Sleep with Lid Close

This makes a laptop sleep on lid close and displays a lockscreen on wake.

Create a file named `sleeplock.service` in `/etc/systemd/system` with the following:

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
Enable the service with
```
sudo systemctl enable sleeplock.service
sudo systemctl start sleeplock.service
```

## Ranger

Remove the existing ranger config directory if it already exists:

```
rm -rf ~/.config/ranger
```
Link to the dotiles config

```
ln -s /home/username/.ranger /home/username/.config/ranger
```

## VPN

[Airvpn](https://airvpn.org/) is used as a VPN service.

### Option 1 - No Network Lock

Openvpn is used to interface with airvpn, it automatically chooses the best server. First generate configuration files using the airvpn online config file generator, make a single file for all Earth. Download the file.

The downloaded configuration file needs to be modified at the end of the first section, before <ca> add:
```
script-security 2
up /etc/openvpn/scripts/update-systemd-resolved
down /etc/openvpn/scripts/update-systemd-resolved
```

Move the configuration file to the home directory, rename it to `.airvpn_config_all.ovpn`.

Add the following to visudo, using a comma between commands if needed:

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/openvpn
```

Enable the required services
```
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service
```
The vpn is started like so:
```
sudo openvpn ~/.airvpn_config_all.ovpn
```

This can be added to `.i3/config` if auto-start is required.


### VPN Option 2 - Network Lock and IP tables

For this option, a single (or multiple) airVPN server is chosen, all external traffic is cut unless this connection is made. The process outlines the addition of a single server. More can be added by repeating these steps.

1. Download a configuration file for 1 server on airVPN site.

2. Follow  [these](https://airvpn.org/topic/25244-airvpn-using-network-manager-in-ubuntumint/) instructions to add VPN to network manager app.

3. For network lock, the IP table (/etc/iptables/iptables.rules) needs to be edited. A complete file might look like this, replace x with the IP address of the server.

```
*filter
# Here are the default settings
#:INPUT ACCEPT [0:0]
#:FORWARD ACCEPT [0:0]
#:OUTPUT ACCEPT [0:10]

# These are for VPN
# Change adapter wlp1s0 and tunnel tun0 to suit device
# Final line with DROP is the IP address of the VPN servers to connect to
#
# HYDRA
#-A OUTPUT -o wlp1s0+ ! -d xxx.xxx.xxx.xxx -j DROP 

-A INPUT -i lo -j ACCEPT
-A OUTPUT -o lo -j ACCEPT 
-A OUTPUT -d 255.255.255.255 -j ACCEPT 
-A INPUT -s 255.255.255.255 -j ACCEPT 
-A INPUT -s 192.168.0.0/16 -d 192.168.0.0/16 -j ACCEPT 
-A OUTPUT -s 192.168.0.0/16 -d 192.168.0.0/16 -j ACCEPT
-A FORWARD -i wlp1s0+ -o tun0+ -j ACCEPT
-A FORWARD -i tun0+ -o wlp1s0+ -j ACCEPT 
-A OUTPUT -o wlp1s0+ ! -d xxx.xxx.xxx.xxx -j DROP 
COMMIT
```

4. The rules need to be enabled with

```
sudo systemctl enable iptables
sudo systemctl start iptables
```

They can also be reloaded after changing the IP table with: 
```
sudo systemctl restart iptables
```

A complete list of airvpn ip addresses can be found using
```
dig ANY ch.all.vpn.airdns.org @dns1.airvpn.org +short
```

These all could be added to the IP tables allowed addresses somehow, I tried and it didn't work.

## Disable PC Speaker (BEEP)

Disable the kernal module and prevent it from being reloaded

```
sudo rmmod pcspkr
sudo bash -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'
```

## Wine

Before installing Wine, the [multilib](https://wiki.archlinux.org/index.php/Official_repositories#multilib) package needs to be enabled.

Uncomment the following in `/etc/pacman.conf`:

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Perform a system upgrade to get the multilib repositories:

```
sudo pacman -Syu
```

Install Wine:
```
sudo pacman -S wine
```

## Virtual Machines

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

Disable the mini-bar and status-bar in user interface tab.


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

## Changing Usernamse

To change the user name you cannot be logged in as that user. First logout and login as root.

```
# usermod -l newname oldname
```

## RAID

Don't use intel rapid storage technology

This is for creating a NEW raid 1 array, with two disks


1. Identify the disks with lsblk
2. Create the array, assuming the disks are at /dev/sdb and /dev/sdc

```
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
```

3. Check the progress of the sync with

```
cat /proc/mdstat
```
4. Create partition tables, make the file systems with fdisk, gdisk, parted, gparted etc..

5. Add the partitions to fstab where required, UUID can be found with 

```
blkid
```

## Samba

After installing the Samba package, a [configuration file](https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD) needs to be made and placed at /etc/samba/smb.conf.

1. Add a new user, this will also require a password to be set.
```
smbpasswd -a username
```

2. Make a directory to share

3. Append the shared folder properties to the configuration file /etc/samba/smb.conf
```
[<directory_name>]
path = /home/<user_name>/<directory_name>
available = yes
valid users = <user_name>
read only = no
browsable = yes
public = yes
writable = yes
```
4. Enable / start / restart the samba service

```
sudo systemctl enable smb
sudo systemctl start smb
sudo systemctl restart smb
```

5. In Windows, the new network drive can be mapped using the hosts IP and directory name, such as
```
\\192.168.x.xx\share
```

6. On Linux machines, it is easier to use sshfs

## AOE HD

1. In steam, enable beta testing in setting->account, restart Steam.
2. Under setting->steamPlay enable Steam for all other titles, restart Steam.
3. Install AOE
4. Under .steam/steam/steamapps/common/Age2HD, change AoK.exe to Launcher.exe, the original Launcher.exe can be deleted.
5. Wollolooo


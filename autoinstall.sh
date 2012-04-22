#!/bin/bash
#
#author: daniel föhn aka troopa (troopa.der.pate@gmail.com)
#description: a little installation script for an ArchLinux system
#             it installs packages and put the config files into the right place
#date: 2012-03-31

#make awesome and cairo-xcb packages from AUR in a temporary folder
cd

mkdir tmp/ && cd tmp/

wget http://aur.archlinux.org/packages/te/teamspeak3/teamspeak3.tar.gz && tar -xzf teamspeak3.tar.gz
wget https://aur.archlinux.org/packages/aw/awesome/awesome.tar.gz && tar -xzf awesome.tar.gz
wget https://aur.archlinux.org/packages/ca/cairo-xcb/cairo-xcb.tar.gz && tar -xzf cairo-xcb.tar.gz

cd cairo-xcb && makepkg -s && sudo pacman -U --noconfirm *.xz
cd ../awesome && makepkg -s && sudo pacman -U --noconfirm awesome-3.4.11-2-x86_64.pkg.tar.xz
cd ../teamspeak3 && makepkg -s && sudo pacman -U --noconfirm *.xz

cd && echo "AUR packages successful installed"

#remove tmp/ folder and create .xinitrc
rm -r tmp/
echo "#!/bin/bash" > ~/.xinitrc
echo "exec ck-launch-session dbus-launch awesome" >> ~/.xinitrc
echo ".xinitrc successful created"

#install all packages which are determined for this system
while read package
do
set $package
    packages="$packages $package"
done < ~/install/packages.txt
#sudo pacman -S $packages
sudo pacman -S --noconfirm $packages
echo "packages successful installed"

#copy all config to the system
echo "configurationfiles successful copied"

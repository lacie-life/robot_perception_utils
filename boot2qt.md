## Note for creating image for Raspberry Pi 4 using Yocto project and boot2qt 

### Hardware

- CPU: i7-8700
- Ram: 32GB

### OS

- Ubuntu 20.04
- Qt version 5.15

## Install required packages

```
sudo apt-get install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev python git-lfs g++-multilib gcc-multilib libxkbcommon-dev libxkbcommon-x11-dev libwayland-cursor++0 libwayland-cursor0

sudo dpkg-reconfigure dash

```
## Install repo 

Repo is a tool built on top of Git. Repo helps manage many Git repositories, does the uploads to revision control systems, and automates parts of the development workflow.

```
mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo
```

## Use the repo tool to clone all the git repositories of the Yocto project and boot2qt at once. First initialize for the correct Qt version:

```
cd ~

git clone -b dunfell git://git.yoctoproject.org/poky.git poky-dunfell

cd poky-dunfell

git clone -b dunfell git://git.openembedded.org/meta-openembedded
git clone -b dunfell https://github.com/meta-qt5/meta-qt5
git clone -b dunfell git://git.yoctoproject.org/meta-raspberrypi
git clone -b dunfell git://git.yoctoproject.org/meta-security.git

git clone -b dunfell https://github.com/jumpnow/meta-jumpnow

mkdir ~/rpi64
cd ~/rpi64
git clone -b dunfell git://github.com/jumpnow/meta-rpi64

```
## Initialize the build directory

```
mkdir -p ~/rpi64/build/conf
source ~/poky-dunfell/oe-init-build-env ~/rpi64/build

cp meta-rpi64/conf/local.conf.sample build/conf/local.conf
cp meta-rpi64/conf/bblayers.conf.sample build/conf/bblayers.conf

```

## Run the build

```
bitbake qt5-image

```

## Copying the binaries to an SD card (or eMMC)

lsblk is convenient for finding the microSD card.

```
cd ~/rpi64/meta-rpi64/scripts
sudo ./mk2parts.sh sdc

sudo mkdir /media/card

export MACHINE=raspberrypi4-64
./copy_boot.sh sdc
./copy_rootfs.sh sdc qt5 rpi4

```

## WiFi setting

```
vi /etc/wpa_supplicant.conf

```

Change to content to following

```
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
update_config=1
network={
    ssid="<SSID_NAME>"
    psk="<PASSWORD>"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP
    auth_alg=OPEN
}
```

Reboot and configure WiFi

```
reboot

ifup wlan0
```

## Refer

<iframe src="//www.slideshare.net/slideshow/embed_code/key/pTvcqAtLLaPOLV" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/MenderOTA/configuring-wifi-in-open-embedded-builds" title="Configuring wifi in open embedded builds" target="_blank">Configuring wifi in open embedded builds</a> </strong> from <strong><a href="//www.slideshare.net/MenderOTA" target="_blank">Mender.io</a></strong> </div>

[Building 64-bit Systems for Raspberry Pi 4 with Yocto](https://jumpnowtek.com/rpi/Raspberry-Pi-4-64bit-Systems-with-Yocto.html)

[Raspberry Pi – Yocto WiFi configuration for automatic connection at boot](https://reiwaembedded.com/raspberry-pi-yocto-wifi-configuration-for-automatic-connection-at-boot/)

[Configure wlan0 and bluetooth in Yocto Raspberry Pi 3](https://raspinterest.wordpress.com/2017/02/28/configure-wlan0-and-bluetooth-in-yocto-raspberry-pi-3/)

[RPi4 and Qt Development](https://jumpnowtek.com/rpi/RPi4-and-Qt-Development.html)







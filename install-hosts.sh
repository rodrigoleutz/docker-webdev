#!/bin/bash

##
##  Projeto:    Docker para programar em PHP
##  Autor:      Rodrigo Leutz
##

DOCKERIP="172.19.0.5"

##	Checa se host existe
check_host(){
	if grep -qF "$DOCKERIP       $1" /etc/hosts;then
		echo "Exist: $1"
	else
		sudo sh -c "echo '$DOCKERIP       $1' >> /etc/hosts"
		echo "Add: $1"
	fi
}

cd webdev
echo "Enter the sudo password to install."
DISTRO=`cat /etc/*-release | grep ^ID | awk -F= '{ print $2 }' | head -n 1`
if [ "$DISTRO" == "arch" ]; then
	yes | sudo LC_ALL=en_US.UTF-8 pacman -S docker docker-compose
elif [ "$DISTRO" == "ubuntu" ]; then
	sudo apt install -y docker docker-compose
elif [ "$DISTRO" == "fedora" ]; then
	echo "WARNING!!!"
	echo "To install on Fedora will disable firewalld, selinux and change the cgroups"
	echo "Type 'yes' to install or 'no' to cancel:"
	read OPT
	if [ "$OPT" == "yes" ]; then
		sudo dnf install -y docker-compose moby-engine
		sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
		sudo sed -i -e '/SELINUX=/s/=.*/=disabled/' /etc/selinux/config 
		sudo systemctl disable firewalld
	else
		exit
	fi
fi
sudo systemctl enable --now docker
check_host "dev.php8"
check_host "dev.php7"
check_host "dev.php5"
check_host "dev.wp"
check_host "dev.phpmyadmin"
if [ "$DISTRO" == "fedora" ]; then
	echo ""
	echo "---------------------"
	echo "Installation complete"
	echo "   Now will Reboot ."
	echo "    To start use:"
	echo "     ./activate"
	echo "---------------------"
	echo
	echo "Press enter to continue"
	read
	sudo reboot
	exit
fi
sudo docker-compose up -d
echo ""
echo "---------------------"
echo "Installation complete"
echo "---------------------"
echo

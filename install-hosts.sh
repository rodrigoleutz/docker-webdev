#!/bin/bash

##
##  Projeto:    Docker para programar em PHP
##  Autor:      Rodrigo Leutz
##

DOCKERIP="172.19.0.5"

##	Checa se host existe
check_host(){
	if grep -qF "$DOCKERIP       $1" /etc/hosts;then
		echo "Existe: $1"
	else
		sudo sh -c "echo '$DOCKERIP       $1' >> /etc/hosts"
		echo "Add: $1"
	fi
}

cd webdev
echo "Digite o password do sudo para instalar"
DISTRO=`cat /etc/*-release | grep ^ID | awk -F= '{ print $2 }'`
if [ "$DISTRO" == "arch" ]; then
	yes | sudo LC_ALL=en_US.UTF-8 pacman -S docker docker-compose
elif [ "$DISTRO" == "ubuntu" ]; then
	sudo apt install -y docker docker-compose
elif [ "$DISTRO" == "fedora" ]; then
	sudo dnf install -y docker docker-compose
fi
sudo systemctl enable --now docker
sudo docker-compose up -d
check_host "dev.php8"
check_host "dev.php7"
check_host "dev.php5"
check_host "dev.wp"
check_host "dev.phpmyadmin"
echo ""
echo "-------------------"
echo "Instalação completa"
echo "-------------------"
echo

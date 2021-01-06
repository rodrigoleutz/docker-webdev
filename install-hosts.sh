#!/bin/bash
$DOCKERIP="172.19.0.5"

##	Checa se host existe
check_host(){
	if grep -qF "$1" /etc/hosts;then
		echo "Existe: $1"
	else
		sudo sh -c '"'$1'" >> /etc/hosts'
		echo "Add: $1"
	fi
}

cd webdev
echo "Digite o password do sudo para instalar"
yes | sudo LC_ALL=en_US.UTF-8 pacman -S docker docker-compose
sudo systemctl enable --now docker
sudo docker-compose up -d
check_host "$DOCKERIP       dev.php8"
check_host "$DOCKERIP       dev.php7"
check_host "$DOCKERIP       dev.php5"
check_host "$DOCKERIP       dev.wp"
check_host "$DOCKERIP       dev.phpmyadmin"
echo "Hosts adicionados"
echo "Instalação completa"

#!/bin/bash

cd webdev
echo "Digite o password do sudo para instalar"
yes | sudo LC_ALL=en_US.UTF-8 pacman pacman -S docker docker-compose
sudo systemctl enable --now docker
sudo docker-compose up -d
IP=`sudo docker inspect nginx | grep IPAddress | tail -n 1 | awk -F'"' '{ print $4 }'`
sudo sh -c 'echo "172.19.0.5       dev.php8" >> /etc/hosts'
sudo sh -c 'echo "172.19.0.5       dev.php7" >> /etc/hosts'
sudo sh -c 'echo "172.19.0.5       dev.php5" >> /etc/hosts'
sudo sh -c 'echo "172.19.0.5       dev.wp" >> /etc/hosts'
echo "Hosts adicionados"
echo "Instalação completa"

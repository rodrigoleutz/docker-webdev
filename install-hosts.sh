#!/bin/bash

echo "Digite o password para obter o IP do docker"
IP=`sudo docker inspect nginx | grep IPAddress | tail -n 1 | awk -F'"' '{ print $4 }'`

sudo sh -c 'echo "'$IP'       dev.php8" >> /etc/hosts'
sudo sh -c 'echo "'$IP'       dev.php7" >> /etc/hosts'
sudo sh -c 'echo "'$IP'       dev.php5" >> /etc/hosts'
sudo sh -c 'echo "'$IP'       dev.wp" >> /etc/hosts'

echo "Hosts adicionados"

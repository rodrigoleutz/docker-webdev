#!/bin/bash

##
##  Projeto:    Docker para programar em PHP
##  Autor:      Rodrigo Leutz
##
echo "Digite a senha do sudo para desativar."
if [ "$DISTRO" == "fedora" ]; then
        sudo setenforce 1
fi
cd webdev
echo
sudo docker-compose down
echo
echo "------------------------------------------"
echo "Docker para programação em PHP desativado."
echo "------------------------------------------"
echo

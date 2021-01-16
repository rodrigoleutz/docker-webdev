#!/bin/bash

##
##  Projeto:    Docker para programar em PHP
##  Autor:      Rodrigo Leutz
##
echo "Digite a senha do sudo para ativar."
cd webdev
echo
sudo docker-compose up -d
echo
echo "---------------------------------------"
echo "Docker para programação em PHP ativado."
echo "---------------------------------------"
echo

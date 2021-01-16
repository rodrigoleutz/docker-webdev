#!/bin/bash

##
##  Projeto:    Docker para programar em PHP
##  Autor:      Rodrigo Leutz
##
echo
echo "Enter the sudo password to activate."
cd webdev
sudo docker-compose up -d
echo
echo "---------------------------------------"
echo " Docker for PHP programming is enabled."
echo "---------------------------------------"
echo

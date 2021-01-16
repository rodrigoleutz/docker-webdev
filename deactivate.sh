#!/bin/bash

##
##  Projeto:    Docker para programar em PHP
##  Autor:      Rodrigo Leutz
##
echo
echo "Enter the sudo password to deactivate.."
cd webdev
sudo docker-compose down
echo
echo "------------------------------------------"
echo " Docker for PHP programming is disabled."
echo "------------------------------------------"
echo

# docker-webdev
Docker para programar em PHP

<pre>
Autor:		Rodrigo Leutz
License:	GPL v2.0
</pre>

<center><a href="https://www.youtube.com/watch?v=rDWlNzBljS0" target="_blank"><img src="img/php-docker.png"></a></center>


<h2>Instruções:</h2>
-------------------------------------------

<h3>Instalar</h3>
<h5>Arch Linux / Fedora / Ubuntu</h5>
	./install-hosts.sh
<br>
<h3>Ativar</h3>
	./activate.sh
<br>
<h3>Desativar</h3>
	./deactivate.sh
<br>

-------------------------------------------


<h3>Para utilizar acesse no navegador:</h3>

- PHP 5.6: http://dev.php5

- PHP 7.4: http://dev.php7

- PHP 8.0: http://dev.php8

- Wordpress: http://dev.wp

- phpMyAdmin: http://dev.phpmyadmin
<pre>
-- User: root
-- Password: senha123
</pre>

- Mysql digite no bash: sudo docker exec -it db mysql -u root -psenha123


<h3>Pasta dos arquivos</h3>
<pre>
├── activate.sh = Activate script
├── deactivate.sh = Deactivate script
├── img
│   └── php-docker.png
├── install-hosts.sh = Install script
├── README.md = This file
└── webdev
    ├── build = Dockerfiles
    │   ├── php5-fpm
    │   │   └── Dockerfile
    │   ├── php7-fpm
    │   │   └── Dockerfile
    │   └── php8-fpm
    │       └── Dockerfile
    ├── database = Database server files
    │   └── README.md
    ├── docker-compose.yaml = docker-compose file
    ├── nginx
    │   ├── conf = NGINX server config
    │   │   ├── nginx.conf
    │   │   └── snippets
    │   │       └── fastcgi-php.conf
    │   ├── defaults = Default server config file
    │   │   └── defaults.conf
    │   ├── logs = Servers logs
    │   │   └── README.md
    │   └── sites = NGINX servers config files
    │       ├── dev-php5.conf
    │       ├── dev-php7.conf
    │       ├── dev-php8.conf
    │       ├── phpmyadmin.conf
    │       └── wp-dev.conf
    └── nginx-public = Public directory
        ├── dev-php5 = PHP 5.6 server files
        │   ├── index.php
        │   └── info.php
        ├── dev-php7 = PHP 7.4 server files
        │   ├── index.php
        │   └── info.php
        ├── dev-php8 = PHP 8 server files
        │   ├── index.php
        │   └── info.php
        └── wordpress = Wordpress server files
            └── info.php
</pre>

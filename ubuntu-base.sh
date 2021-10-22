#!/bin/bash
# C: Fahad Ahammed
# D: 2021-10-22 09:40:48
# Purpose: Create Ubuntu VM of a predefined set of tools and configurations.

# -- Cautions
# Fail Fast
set -Eeuo pipefail
vcheck() {
    if [ -z "$1" ]
    then
      echo "\$1 is empty"
    else
      echo "\$1 is NOT empty"
      exit
    fi
}


# -- Extra Variables
dt_now=$(date +%Y-%m-%d_%H-%M-%s_%Z)
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# -- Parameters and Check
if [ $# -ge 1 ] && [ -n "$1" ]
then
    hostname="$1"
    vcheck $hostname
else
    echo "No parameters passsed."
    exit
fi

echo "AA"


# -- Useful Functions
musthave() {
    sudo apt update;
    sudo apt install -y zip unzip curl wget nload redis python3 python3-dev virtualenv build-essential certbot python3-certbot-nginx;
    hostnamectl set-hostname $hostname;
    timedatectl set-timezone Asia/Dhaka;
    echo 'vm.swappiness = 10' >> /etc/sysctl.conf;
    echo 'www-data hard nofile 50000' >> /etc/security/limits.conf;
    echo 'www-data soft nofile 50000' >> /etc/security/limits.conf;
    echo 'nginx hard nofile 50000' >> /etc/security/limits.conf;
    echo 'nginx soft nofile 50000' >> /etc/security/limits.conf;
    echo 'root hard nofile 50000' >> /etc/security/limits.conf;
    echo 'root soft nofile 50000' >> /etc/security/limits.conf;
}

phpinstall() {
    sudo apt update;
    sudo apt install -y php-fpm;
    sudo apt install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-redis;
}

nginxinstall() {
    sudo apt update;
    sudo apt install -y nginx;
    sudo apt install -y apache2-utils;
}

nodejsinstall() {
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs;
}


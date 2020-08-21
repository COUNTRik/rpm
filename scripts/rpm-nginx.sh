# #!/bin/bash

# Установим репозиторий EPEL
yum install -y epel-release

# Установим nginx 
yum install -y nginx

# Запустим nginx
systemctl start nginx

# Создадим папку, сохраним пару пакетов и инициализируем наш репозиторий
mkdir /usr/share/nginx/html/rpm

wget https://mirror.yandex.ru/centos/7/os/x86_64/Packages/mc-4.8.7-11.el7.x86_64.rpm
wget https://mirror.yandex.ru/centos/7/os/x86_64/Packages/iputils-20160308-10.el7.x86_64.rpm

createrepo /usr/share/nginx/html/rpm

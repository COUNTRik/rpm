# #!/bin/bash

# Создадим папку для нашего локального резпозитория 
mkdir /mnt/localrepo

# Загрузим несколько пакетов с зеркала яндекс
wget https://mirror.yandex.ru/centos/7/os/x86_64/Packages/mc-4.8.7-11.el7.x86_64.rpm
wget https://mirror.yandex.ru/centos/7/os/x86_64/Packages/iputils-20160308-10.el7.x86_64.rpm

# Инициализируем наш репозиторий
createrepo /mnt/localrepo/

# Создаем файл local.repo с настройками для локального репозитария
cat >> /etc/yum.repos.d/local.repo << EOF
[localrepo]
name=localrepo
baseurl=file:///mnt/localrepo
gpgcheck=0
enabled=1
EOF

# Инициализируем наш репозиторий
createrepo /mnt/localrepo/

# Выведем список репозиториев
yum repolist
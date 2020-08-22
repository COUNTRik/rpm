# Работа с rpm, yum и repo

В каталоге scripts находятся скрипты для работы

## Установка необходимых пакетов для сборки rpmпакета

При запуске Vagrantfile запустит скрипт rpm-install.sh для установки необоходимых пакетов.

## Создание своего rpm пакета

Копируем из /vagrant в домашний каталог /home/vagrant скрипт для сборки

``cp /vagrant/scripts/build-rpm.sh /home/vagrant``

Даем права на исполнение скрипту для сборки

``chmod ugo+x build-rpm.sh``

Запускаем скрипт с правами sudo

``sudo /home/vagrant/build-rpm``

Пакет собран.

## Создание локального репозитория

Все шаги описаны в скрипте rpm-localrepo.sh

## Создание локального репозитория на nginx

Установим репозиторий EPEL

``yum install -y epel-release``

Установим nginx 

``yum install -y nginx``

Запустим nginx

``systemctl start nginx``

Создадим папку, сохраним пару пакетов и инициализируем наш репозиторий

``mkdir /usr/share/nginx/html/rpm``

``wget https://mirror.yandex.ru/centos/7/os/x86_64/Packages/mc-4.8.7-11.el7.x86_64.rpm``

``wget https://mirror.yandex.ru/centos/7/os/x86_64/Packages/iputils-20160308-10.el7.x86_64.rpm``

``createrepo /usr/share/nginx/html/rpm``

Закоментируем секцию server в /etc/nginx/nginx.conf и создадим конфигурационный файл в /etc/nginx/conf.d/default.conf с нижеописанными настройками

``server {

    listen 80;

    server_name localhost;

    location / {

    autoindex on;

    root /usr/share/nginx/html;

    }

}``

Проверим синтаксис нового конфигурационного файла и перезапустим nginx

``nginx -t``

``nginx -s reload``

По аналогии с локальным репозиторием cоздаем файл localnginx.repo с настройками для локального репозитария
``cat >> /etc/yum.repos.d/localnginx.repo << EOF

[localnginx]

name=localnginx

baseurl=http://localhost/rpm

gpgcheck=0

enabled=1

EOF``

Выведем список репозиториев
``yum repolist``
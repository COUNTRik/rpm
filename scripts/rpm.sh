# #!/bin/bash

# Авторизуемся для получения root прав
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

# Устанавливаем необходимые пакеты
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc

# Загрузим SRPM пакет NGINX для дальнейшей работы над ним
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm

# Создадим дерево каталогов для сбокри путем установки этого пакета в домашнюю директорию
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

# Скачаем последнюю версию исходников openssl и разахивирем ее
wget https://www.openssl.org/source/latest.tar.gz
tar -xvf latest.tar.gz

# Поставим все зависимости чтобы в процессе сборки не было ошибок
yum-builddep rpmbuild/SPECS/nginx.spec

# Добавляем в spec файл путь до исходников openssl
sed 's!with-debug!with-openssl=/home/vagrant/openssl-1.1.1g!' rpmbuild/SPECS/nginx.spec > nginx.spec
cp nginx.spec rpmbuild/SPECS/nginx.spec

# Запускаем сборку пакета
rpmbuild -bb rpmbuild/SPECS/nginx.spec

# Установим собранный nginx, который нам понадобится 
yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm

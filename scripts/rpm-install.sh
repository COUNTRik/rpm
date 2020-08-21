# #!/bin/bash

# Авторизуемся для получения root прав
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

# Обновляем и устанавливаем необходимые пакеты
yum update -y
yum clean all
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc

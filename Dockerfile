FROM debian:buster

COPY ./init.sh ./tmp/init.sh
COPY ./default_normal ./tmp/default_normal
COPY ./default_auto_index ./tmp/default_auto_index
COPY ./config.inc.php ./tmp/config.inc.php

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get install -y openssl php-fpm wget mariadb-server php-mysql

CMD bash tmp/init.sh





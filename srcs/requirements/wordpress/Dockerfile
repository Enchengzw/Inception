FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get -y install wget

RUN apt-get install -y php7.4 \
php-fpm \
php-mysql \
mariadb-client \
curl

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php
RUN chmod 755 /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wp_config.sh /usr/local/bin/wp_config.sh
RUN chmod +x /usr/local/bin/wp_config.sh

EXPOSE 9000

WORKDIR /var/www/html/

ENTRYPOINT ["sh", "/usr/local/bin/wp_config.sh"]
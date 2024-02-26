FROM  alpine:3.18

RUN apk update \
    && apk upgrade \
    && apk add wget mariadb-client php php-fpm php-mysqli vim php-phar php-iconv

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY conf/startwp.sh /scripts/startwp.sh

RUN chmod +x scripts/startwp.sh

CMD ["sh", "/scripts/startwp.sh"]
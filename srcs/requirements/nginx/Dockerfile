FROM alpine:3.18

RUN apk update \
	&& apk upgrade \
	&& apk add nginx vim openssl \
	&& mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
		-keyout /etc/nginx/ssl/inception.key \
		-subj "/C=SP/ST=MLG/L=Malaga/O=42/CN=vde-prad.42.fr/UID=vde-prad" 

COPY conf/nginx.conf /etc/nginx/nginx.conf

# RUN chmod  755 /var/www/wordpress \
# 	&& chown -R www-data:www-data /var/www/wordpress

CMD [ "nginx", "-g", "daemon off;" ]

# FROM  alpine:3.18

# RUN apk update  && apk upgrade \
# 	&& apk add vim mariadb mariadb-client openrc\
# 	&& addgroup mysql mysql \
# 	&& mkdir scripts
# RUN openrc \
# 	&& touch /run/openrc/softlevel

# COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
# COPY tools/startdb.sh scripts/startdb.sh

# RUN  chmod +x /scripts/startdb.sh

# CMD ["sh",  "/scripts/startdb.sh"]

FROM alpine:3.18

RUN apk update \
	&& apk upgrade \
	&& apk add vim mariadb mariadb-client openrc \
	&& mkdir scripts

RUN openrc && touch /run/openrc/softlevel

COPY tools/startdb.sh scripts/startdb.sh
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x scripts/startdb.sh

CMD ["sh", "scripts/startdb.sh"]
FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install mariadb-server -y

RUN mkdir -p /var/run/mysqld  && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

EXPOSE 3306

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/config.sh /

ENTRYPOINT ["sh", "./config.sh"]
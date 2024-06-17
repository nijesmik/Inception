# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/

FROM debian:buster

RUN apt-get update
RUN apt-get install mariadb-server -y

EXPOSE 3306

# COPY ./script/initial.sql /var/www/
RUN mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap << EOF && \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; \
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%'; \
    FLUSH PRIVILEGES; \
EOF

CMD [ "mysqld", "--bind-address=0.0.0.0" ]
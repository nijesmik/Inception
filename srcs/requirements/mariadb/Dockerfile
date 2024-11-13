# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/
# https://ninano1109.tistory.com/152

FROM debian:bullseye

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

RUN apt-get update && \
    apt-get install mariadb-server tini -y

EXPOSE 3306

COPY ./script/initial.sh /var/www/initial.sh
RUN chmod +x /var/www/initial.sh

RUN service mysql start

RUN /var/www/initial.sh

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD [ "mysqld", "--bind-address=0.0.0.0" ]
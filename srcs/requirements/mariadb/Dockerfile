# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/

FROM debian:buster

RUN apt-get update
RUN apt-get install mariadb-server -y

EXPOSE 3306

# COPY ./script/initial.sql /var/www/
COPY --chmod=777 ./script/sql_setup.sh /var/www
RUN service mysql start
RUN /var/www/sql_setup.sh

CMD [ "mysqld", "--bind-address=0.0.0.0" ]

# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/

FROM debian:buster

RUN apt-get update
RUN apt-get install mariadb-server -y

EXPOSE 3306

# COPY ./script/initial.sql /var/www/
COPY ./script/initial.sh /var/www/
RUN chmod +x /var/www/initial.sh && \
    /var/www/initial.sh
RUN service mysql start && mysql < /var/www/initial.sql

CMD [ "mysqld", "--bind-address=0.0.0.0" ]
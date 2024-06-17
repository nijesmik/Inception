# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/

FROM debian:buster

RUN apt-get update
RUN apt-get install mariadb-server -y

EXPOSE 3306

# COPY ./script/initial.sql /var/www/
COPY --chmod=777 ./script/create_initial_sql.sh /var/www
RUN sh /var/www/create_initial_sql.sh
RUN service mysql start && mysql < /var/www/initial.sql && rm -f /var/www/initial.sql;

CMD [ "mysqld", "--bind-address=0.0.0.0" ]

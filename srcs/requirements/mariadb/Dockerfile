# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/
# https://ninano1109.tistory.com/152

# FROM debian:buster

# RUN apt-get update
# RUN apt-get install mariadb-server -y

# EXPOSE 3306

# COPY ./script/initial.sql /var/www/
# RUN service mysql start && mysql < /var/www/initial.sql && rm -f /var/www/initial.sql;

# CMD [ "mysqld", "--bind-address=0.0.0.0" ]


FROM debian:buster

ARG MYSQL_HOSTNAME
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD


RUN apt-get update
RUN apt-get install mariadb-server -y

EXPOSE 3306

COPY ./script/initial.sh /var/www/initial.sh
RUN chmod +x /var/www/initial.sh

RUN service mysql start

RUN /var/www/initial.sh

CMD [ "mysqld", "--bind-address=0.0.0.0" ]
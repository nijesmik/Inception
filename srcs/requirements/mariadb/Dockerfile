# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/

FROM debian:buster

RUN apt-get update
RUN apt-get install mariadb-server -y

EXPOSE 3306

COPY ./script/initial.sh /var/www/
RUN touch /var/www/initial.sql
RUN chmod +x /var/www/initial.sh

CMD [ "/var/www/initial.sh" ]
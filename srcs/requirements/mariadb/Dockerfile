FROM debian:buster

RUN apt-get update \
    && apt-get install -y mariadb-server

EXPOSE 3306

# COPY ./script/initial.sh /var/www/
# RUN touch /var/www/initial.sql \
#     && chmod +x /var/www/initial.sh

COPY ./script/initial.sql /var/www

RUN service mysql start && mysql < /var/www/initial.sql

# Run the initial script
# RUN /var/www/initial.sh
    # && rm /var/www/initial.sql

# Start MySQL server in the background
CMD ["mysqld_safe"]

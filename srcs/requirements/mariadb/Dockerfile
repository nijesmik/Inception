FROM debian:buster

# Define build arguments
ARG MYSQL_HOSTNAME
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

# Set environment variables
ENV MYSQL_HOSTNAME=${MYSQL_HOSTNAME}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

RUN apt-get update \
    && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./script/initial.sh /var/www/
RUN touch /var/www/initial.sql \
    && chmod +x /var/www/initial.sh

# Run the initial script
RUN /var/www/initial.sh
    # && rm /var/www/initial.sql

# Start MySQL server in the background
CMD ["mysqld_safe"]

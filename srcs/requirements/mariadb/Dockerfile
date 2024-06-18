FROM debian:buster

RUN apt-get update \
    && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./script/initial.sh /var/www/
RUN touch /var/www/initial.sql \
    && chmod +x /var/www/initial.sh

# Run the initial script
RUN /var/www/initial.sh \
    # && rm /var/www/initial.sql

# Start MySQL server in the background
CMD ["mysqld_safe"]

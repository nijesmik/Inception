# https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/

# Use the official Debian Buster image as a base
FROM debian:buster

# Update package list and install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

# Expose port 3306 for MariaDB
EXPOSE 3306

# Copy the setup script into the container and give it execute permissions
COPY ./script/sql_setup.sh /var/www/sql_setup.sh
RUN chmod +x /var/www/sql_setup.sh

# Start the MySQL service and run the setup script
ENTRYPOINT ["/var/www/sql_setup.sh"]

# Default command to run MariaDB server
CMD ["mysqld", "--bind-address=0.0.0.0"]

FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php7.3-curl php7.3-gd php7.3-intl php7.3-mbstring php7.3-soap php7.3-xml php7.3-xmlrpc php7.3-zip
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz
RUN mv wordpress /var/www/html
RUN chown -R www-data:www-data /var/www/html/wordpress
RUN chmod -R 755 /var/www/html/wordpress
RUN rm -rf latest.tar.gz

COPY srcs/requirements/wordpress/wp-config.php /var/www/html/wordpress/wp-config.php

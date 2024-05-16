FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y nginx

COPY srcs/requirements/nginx/nginx.conf /etc/nginx/sites-available/default
COPY srcs/requirements/nginx/index.html /var/www/html/index.html

EXPOSE 443
FROM	debian:buster

#install all the program
RUN apt-get update
RUN apt-get install -y nginx openssl

# nginx SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/junmoon.crt \
    -keyout /etc/nginx/ssl/junmoon.key \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=junmoon/CN=junmoon/"

COPY ./conf/nginx.conf /etc/nginx/conf.d

# nginx config
RUN mkdir -p /run/nginx

#the only port allowed
EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
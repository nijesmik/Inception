FROM debian:bullseye

# nginx openssl 설치
RUN apt-get update && \
    apt-get install -y nginx openssl tini

# Self-signed certificate 생성
RUN mkdir /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/sejinkim.crt \
    -keyout /etc/nginx/ssl/sejinkim.key \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=sejinkim/CN=sejinkim/"

# nginx config 파일 복사
COPY ./conf/nginx.conf /etc/nginx/conf.d

# nginx 실행시 필요한 디렉토리 생성
RUN mkdir -p /run/nginx

# 443 열기
EXPOSE 443

ENTRYPOINT ["/usr/bin/tini", "--"]

# nginx 실행
CMD ["nginx", "-g", "daemon off;"]
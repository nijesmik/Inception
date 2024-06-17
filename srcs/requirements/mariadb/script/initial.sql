CREATE DATABASE IF NOT EXISTS wordpress;                            -- create database named wordpress
CREATE USER IF NOT EXISTS 'junmoon'@'%' IDENTIFIED BY '1q2w3e4r';   -- create user named junmoon with password
GRANT ALL PRIVILEGES ON wordpress.* TO 'junmoon'@'%';               -- grant privileges on the wordpress* to the junmoon
FLUSH PRIVILEGES;                                                   -- take effect of GRANT command
ALTER USER 'root'@'localhost' IDENTIFIED BY '1q2w3e4r5t';           -- change root user password
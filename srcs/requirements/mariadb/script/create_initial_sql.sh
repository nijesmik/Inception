echo "CREATE DATABASE IF NOT EXISTS wordpress;                                              -- create database named wordpress" >> initial.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_DATABASE'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';      -- create user named junmoon with password" >> initial.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';                       -- grant privileges on the wordpress* to the junmoon" >> initial.sql
echo "FLUSH PRIVILEGES;                                                                     -- take effect of GRANT command" >> initial.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';                   -- change root user password" >> initial.sql
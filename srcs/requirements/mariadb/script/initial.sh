echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" >> /var/www/initial.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /var/www/initial.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> /var/www/initial.sql
echo "FLUSH PRIVILEGES;" >> /var/www/initial.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /var/www/initial.sql
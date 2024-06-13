#!/bin/sh

if [ -f ./wp-config.php ]
then
	# wp-config 존재
	echo "err: wp-config exists"
else
	# https://ko.wordpress.org/download/#download-install
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
	# https://github.com/WordPress/WordPress/blob/master/wp-config-sample.php
	cp wp-config-sample.php wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
fi

exec "$@"
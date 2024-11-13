#!/bin/sh

if [ -f ./wp-config.php ]
then
	# wp-config 존재
	echo "wp-config exists"
else
	# https://ko.wordpress.org/download/#download-install
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# https://nolboo.kim/blog/2016/05/16/ultimate-wordpress-development-environment-wp-cli/
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	wp config create --dbname=$MYSQL_DATABASE \
					 --dbuser=$MYSQL_USER \
					 --dbpass=$MYSQL_PASSWORD \
					 --dbhost=$MYSQL_HOSTNAME \
					 --allow-root

	wp core install	--url=$DOMAIN_NAME \
					--title=$WP_TITLE \
					--admin_user=$WP_ROOT_NAME \
					--admin_password=$WP_ROOT_PASSWORD \
					--admin_email=$WP_ROOT_EMAIL \
					--allow-root
	wp user create $WP_USER_NAME $WP_USER_EMAIL \
					--user_pass=$WP_USER_PASSWORD \
					--allow-root
fi

exec "$@"
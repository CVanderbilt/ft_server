openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=SP/ST=Madrid/L=Madrid/O=42/OU=42madrid/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
chmod 600 localhost.dev.*
mv localhost.dev.crt etc/ssl/certs/localhost.dev.crt
mv localhost.dev.key etc/ssl/private/localhost.dev.key

wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz

tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin
mv phpmyadmin /var/www/html
cp -rp var/www/html/phpmyadmin/config.sample.inc.php var/www/html/phpmyadmin/config.inc.php

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/ var/www/html/
chown -R www-data:www-data /var/www/html/wordpress

if [ -z ${AUTO+x} ];
	then echo "var is unset";
	else echo "var is set to '$AUTO'";
fi

if [ -z ${AUTO+x} ];
	then mv tmp/default_normal tmp/default;
	else mv tmp/default_auto_index tmp/default;
fi
mv tmp/default etc/nginx/sites-enabled/default
mv tmp/config.inc.php var/www/html/phpmyadmin/config.inc.php

service nginx start
service php7.3-fpm start
service php7.3-fpm status
service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

bash

apt-get update

apt-get -y install nginx
apt-get -y install mariadb-server mariadb-client
apt-get -y install php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath
apt-get -y install unzip git curl


cp wordpress.conf /etc/nginx/sites-available/wordpress.conf
ln -s /etc/nginx/sites-available/wordpress.conf  /etc/nginx/sites-enabled/

mysql_secure_installation
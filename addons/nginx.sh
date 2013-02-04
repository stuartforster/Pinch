#!/bin/bash -e

#
# Pinch Nginx Addon
# Deploys Nginx Web Server
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

function pinch_nginx() {

messenger "Downloading & Compiling Nginx"

cd ${PARAM_LEMP_FILES}
pinch_url_exists http://nginx.org/download/nginx-${PARAM_NGINX_VERSION}.tar.gz
tar -xvf nginx-${PARAM_NGINX_VERSION}.tar.gz
cd nginx-${PARAM_NGINX_VERSION}

# Add SPDY Support http://nginx.org/patches/spdy/
pinch_url_exists http://nginx.org/patches/spdy/patch.spdy.txt
patch -p1 < patch.spdy.txt

./configure \
	--prefix=${PARAM_NGINX_PREFIX} \
	--http-log-path=${PARAM_NGINX_HTTP_LOG} \
	--error-log-path=${PARAM_NGINX_ERR_LOG} \
	--pid-path=/var/run/nginx.pid \
	--lock-path=/var/lock/nginx.lock \
	--with-http_stub_status_module \
	--with-http_ssl_module \
	--with-http_realip_module \
	--with-http_gzip_static_module \
	--user=${PARAM_NGINX_USER} \
	--group=${PARAM_NGINX_USER} \
	--without-mail_pop3_module \
	--without-mail_imap_module \
	--without-mail_smtp_module \
	--with-http_spdy_module \
	--with-openssl=${PARAM_LEMP_FILES}/openssl-${PARAM_OPENSSL_VERSION}

make && make install

useradd -M ${PARAM_NGINX_USER}

ln -s ${PARAM_NGINX_PREFIX}/sbin/* /usr/bin/

cp ${PARAM_SRC_DIR}/assets/nginx/nginx-upstart.sh /etc/init.d/nginx

chkconfig --add nginx && chkconfig nginx on

chown -R ${PARAM_NGINX_USER}:${PARAM_NGINX_USER} ${PARAM_NGINX_PREFIX}

chmod +x /etc/init.d/nginx

/etc/init.d/nginx start

sleep 5

#
# Pinch Nginx Configuration
# Configures Nginx for Development Use
#

# Backup NGINX Configuration Files
mv ${PARAM_NGINX_PREFIX}/conf/nginx.conf ${PARAM_NGINX_PREFIX}/conf/nginx.conf.backup

# Copy Nginx Configuration Files
cp ${PARAM_SRC_DIR}/assets/nginx/nginx.conf ${PARAM_NGINX_PREFIX}/conf/nginx.conf 

# Create Sites Enabled / Available Directories
mkdir ${PARAM_NGINX_PREFIX}/sites-enabled
mkdir ${PARAM_NGINX_PREFIX}/sites-available

# Copy Default Site Configuration Files

	# Generic
	cp ${PARAM_SRC_DIR}/assets/nginx/default.conf ${PARAM_NGINX_PREFIX}/sites-available/default.conf
	mkdir /var/www/default
	chown -r ${PARAM_NGINX_USER}:${PARAM_NGINX_USER} /var/www/default
	echo "Welcome to your new site running Nginx ${PARAM_NGINX_VERSION}, PHP-FPM ${PARAM_PHP_VERSION}, APC & MariaDB ${PARAM_MARIADB_VERSION}!" > /var/www/default/index.php
	echo "<?php phpinfo(); ?>" > /var/www/default/index.php

	# WordPress
	cp ${PARAM_SRC_DIR}/assets/nginx/default-wordpress.conf ${PARAM_NGINX_PREFIX}/sites-available/default-wordpress.conf
	mkdir /var/www/default-wordpress
	chown -r ${PARAM_NGINX_USER}:${PARAM_NGINX_USER} /var/www/default-wordpress
	echo "Welcome to your new site running Nginx ${PARAM_NGINX_VERSION}, PHP-FPM ${PARAM_PHP_VERSION}, APC & MariaDB ${PARAM_MARIADB_VERSION}!" > /var/www/default-wordpress/index.php
	echo "You can now go ahead and install WordPress. You won't need to worry about the configuration files, permalink support etc has been built in." > /var/www/default-wordpress/index.php
	echo "<?php phpinfo(); ?>" > /var/www/default-wordpress/index.php

	# Generic + SPDY (Requires SSL)
	cp ${PARAM_SRC_DIR}/assets/nginx/default-spdy.conf ${PARAM_NGINX_PREFIX}/sites-available/default-spdy.conf
	mkdir /var/www/default-spdy
	chown -r ${PARAM_NGINX_USER}:${PARAM_NGINX_USER} /var/www/default-spdy
	echo "Welcome to your new site running Nginx ${PARAM_NGINX_VERSION}, PHP-FPM ${PARAM_PHP_VERSION}, APC, MariaDB ${PARAM_MARIADB_VERSION} & SPDY!" > /var/www/default-spdy/index.php
	echo "<?php phpinfo(); ?>" > /var/www/default-spdy/index.php

	# Link File to Sites Enabled
	ln -s ${PARAM_NGINX_PREFIX}/sites-available/default.conf ${PARAM_NGINX_PREFIX}/sites-enabled/default.conf

}
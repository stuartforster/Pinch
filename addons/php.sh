#!/bin/bash -e

#
# Pinch PHP Addon
# Deploys PHP
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

function pinch_php() {

messenger "Downloading & Compiling PHP with PHP-FPM"

cd ${PARAM_LEMP_FILES}
pinch_url_exists http://php.net/get/php-${PARAM_PHP_VERSION}.tar.bz2/from/this/mirror
tar -xvjf php-${PARAM_PHP_VERSION}.tar.bz2
cd php-${PARAM_PHP_VERSION}

./configure \
	--prefix=${PARAM_PHP_PREFIX} \
	--with-config-file-path=${PARAM_PHP_PREFIX} \
	--with-config-file-scan-dir=${PARAM_PHP_PREFIX}/conf.d \
	--with-fpm-user=${PARAM_PHP_FPM_USER} \
	--with-fpm-group=${PARAM_PHP_FPM_USER} \
	--enable-fpm \
	--with-mcrypt \
	--with-mhash \
	--enable-zip \
	--with-bz2 \
	--with-mysql \
	--with-mysqli \
	--with-curl \
	--with-pear \
	--with-gd \
	--with-zlib \
	--with-openssl \
	--with-xmlrpc \
	--with-xsl \
	--with-gettext \
	--disable-debug \
	--enable-cli \
	--enable-inline-optimization \
	--enable-mbstring \
	--enable-sockets 

make && make install

useradd -M ${PARAM_PHP_FPM_USER}

cp php.ini-production ${PARAM_PHP_PREFIX}/php.ini

ln -s ${PARAM_PHP_PREFIX}/sbin/* /usr/bin/ && ln -s ${PARAM_PHP_PREFIX}/bin/* /usr/bin/

mv ${PARAM_PHP_PREFIX}/etc/php-fpm.conf.default ${PARAM_PHP_PREFIX}/etc/php-fpm.conf
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm

chkconfig --add php-fpm && chkconfig php-fpm on

chown -R ${PARAM_PHP_FPM_USER}:${PARAM_PHP_FPM_USER} ${PARAM_PHP_PREFIX}

chmod +x /etc/init.d/php-fpm

/etc/init.d/php-fpm start

sleep 5

# Backup PHP.ini
mv ${PARAM_PHP_PREFIX}/php.ini ${PARAM_PHP_PREFIX}/php.ini.backup

# Deploy PHP.ini
cp ${PARAM_SRC_DIR}/assets/php/php.ini ${PARAM_PHP_PREFIX}/php.ini

}
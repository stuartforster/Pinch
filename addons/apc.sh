#!/bin/bash -e

#
# Pinch PHP-APC Addon
# Deploys PHP-APC
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

function pinch_apc() {

messenger "Download, Compile & Activate APC"

cd ${PARAM_LEMP_FILES}
installer_url_exists http://pecl.php.net/get/APC
tar -xzf APC
cd APC-*

phpize

./configure --with-php-config=${PARAM_PHP_PREFIX}/bin/php-config

make && make install

echo "extension=apc.so" >> ${PARAM_PHP_PREFIX}/php.ini

sleep 5

}

pinch_apc
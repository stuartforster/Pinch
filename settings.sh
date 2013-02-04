#!/bin/bash -e

#
# Pincg Settings
# Global Settings for Pinch
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

# Get Current Date
PARAM_DATE=$(date +%Y-%m-%d)

# LEMP Installer Settings
PARAM_LEMP_FILES="/opt/lemp"
PARAM_LEMP_LOG="/var/log/lemp-${PARAM_DATE}.log"

# Nginx Settings
PARAM_NGINX_PREFIX="/etc/nginx"
PARAM_NGINX_USER="nginx"
PARAM_NGINX_VERSION="1.2.6"
PARAM_NGINX_ERR_LOG="/var/log/nginx/error.log"
PARAM_NGINX_HTTP_LOG="/var/log/nginx/access.log"

# OpenSSL Settings
PARAM_OPENSSL_PREFIX="/etc/openssl"
PARAM_OPENSSL_VERSION="1.0.1c"

# PHP & PHP-FPM Settings
PARAM_PHP_PREFIX="/etc/php5"
PARAM_PHP_FPM_USER="php_fpm"
PARAM_PHP_VERSION="5.4.11"

# MariaDB Settings
PARAM_MARIADB_PREFIX="/etc/mysql"
PARAM_MARIADB_USER="mysql"
PARAM_MARIADB_VERSION="5.5.29"

# Get IPv4 / IPv6 Address
PARAM_PUBLIC_IP=$(curl -s icanhazip.com)
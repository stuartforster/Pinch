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
	--without-mail_smtp_module

make && make install

useradd -M ${PARAM_NGINX_USER}

# Add SPDY Support http://nginx.org/patches/spdy/
pinch_url_exists http://nginx.org/patches/spdy/patch.spdy.txt
patch -p1 < patch.spdy.txt

ln -s ${PARAM_NGINX_PREFIX}/sbin/* /usr/bin/

cp ${PARAM_SRC_DIR}/assets/nginx/nginx-upstart.sh /etc/init.d/nginx

chkconfig --add nginx && chkconfig nginx on

chown -R ${PARAM_NGINX_USER}:${PARAM_NGINX_USER} ${PARAM_NGINX_PREFIX}

chmod +x /etc/init.d/nginx

/etc/init.d/nginx start

sleep 5

}
#!/bin/bash -e

#
# Pinch OpenSSL Addon
# Deploys OpenSSL
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

function pinch_openssl() {

messenger "Downloading OpenSSL"

cd ${PARAM_LEMP_FILES}
pinch_url_exists http://www.openssl.org/source/openssl-${PARAM_OPENSSL_VERSION}.tar.gz
tar -xvf openssl-${PARAM_OPENSSL_VERSION}.tar.gz

}
#!/bin/bash -e

#
# Pinch System Preperation
# Prepares System for Pinch Addons
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

# Create Temporary File Directory

if [ ! -d ${PARAM_LEMP_FILES} ]; then
	mkdir ${PARAM_LEMP_FILES}
fi

# Update System & Install Build Packages

rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum -q -y update

yum -q -y \
	curl \
	install \
	cmake \
	libaio-devel \
	ncurses-devel \
	httpd-devel \
	pcre-devel \
	libxml2-devel \
	openssl-devel \
	libcurl-devel \
	gd-devel \
	zlib-devel \
	bzip2-devel \
	libxslt-devel \
	php-mcrypt \
	libmcrypt-devel

yum -y groupinstall "Development Tools"
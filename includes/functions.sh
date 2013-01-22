#!/bin/bash -e

#
# Pinch Functions
# Global Functions for Pinch
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

# Messenger Function
function messenger() {
	echo -e "\e[00;32m\n**** ${1} ****\n \e[00m"   
}

# URL Wrapper
function pinch_url_exists() {
	wget $1
	if [ $? -eq 0 ]
		then messenger "Succesfully Downloaded... Continuing..."
		else messenger "Download failed, aborting!" && sleep 2 && exit
	fi
}

# Check for Existing Components
function pinch_check() {

	# Check pinch Compatability
	messenger "Checking pinch compatability..."

	OS=$(cat /etc/redhat-release | awk {'print $1}')
	if [[ "$OS" -ne "CentOS" ]]; then
		messenger "Please run this script on CentOS. Exiting..."
		exit
	fi

	# Check for Root Privledges
	messenger "Checking privledges..."

	if [[ $(/usr/bin/id -u) -ne 0 ]]; then
		messenger "Please run this script as root or using sudo. Exiting..."
		exit
	fi

	# Check existing installations
	messenger "Checking existing installations..."

	# Check 1: Existing PIDs
	if [ -e "/var/run/nginx.pid" ] || [ -e "/var/run/php-fpm.pid" ] || [ -e "/var/run/mysql.pid" ];
		then messenger "Seems you might have an existing installation of NGINX, PHP or MariaDB / MySQL."
			 messenger "It is strongly advisiable to run this script on a clean install of CentOS, or with existing installations removed."
			 messenger "Would you like to proceed? y/n"

			 read PARAM_CONTINUE

			if [[ "$PARAM_CONTINUE" = "y" ]] || [[ "$PARAM_CONTINUE" = "Y" ]];
				then messenger "Continuing..."
				else messenger "Exiting..." && exit
			fi

		else messenger "No existing installations of NGINX, PHP or MariaDB / MySQL Found. Proceeding..."
	fi

	# Check 2: Components in Same Location
	# Get PHP / MariaDB / Nginx prefixes with bin, if exist, fail.

}

# Check Succesfull Install
function pinch_success() {
	if [ -e "/var/run/nginx.pid" ] && [ -e "/var/run/php-fpm.pid" ] && [ -e "/var/run/mysql.pid" ];
		then messenger "Success! Head over to ${PARAM_PUBLIC_IP} to see your new LEMP stack in action"
		else messenger "Error: Something went wrong, please scan for any errors in the output log at ${PARAM_INSTALL_LOG}"
	fi
}
#!/bin/bash -x

#
# drewsymo/Pinch
# Generic Controller for Pinch installer
#
# Installs a LEMP stack and sets up system for server production-environment.
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
#

# Create Global Options

## Hostname Option
PINCH_HOSTNAME="host.domain.com"

## Timezone Option
PINCH_TIMEZONE="Australia/NSW"

## Custom SSH Option
PINCH_SSH_PORT="3636"

## New Root User
PINCH_ROOT_USER="sudoninja"

## Root User Password
PINCH_ROOT_USER_PASSWORD="sudoninjapassword"

## MariaDB Root Password
PINCH_MARIADB_PASSWORD="mariadbpassword"

(

# Retrieve Pinch Library
. pinch_library.sh

# Run Pinch Installer
pinch=(
	'pinch_essentials'
	'pinch_rpm'
	'pinch_nginx'
	'pinch_php'
	'pinch_varnish'
	'pinch_mariadb'
	'pinch_security'
	'pinch_configure_lemp'
	'pinch_engage'
)

for i in "${pinch[@]}"
do
	echo -e '\E[37;44m'"\033[1m [$i] Running $i \033[0m"
	$i
	wait
done

) 2>&1 | tee /var/log/stackscript.log
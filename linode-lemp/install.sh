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

# Create UDF Options

## Hostname Option
#<udf name="pinch_hostname" label="Your server hostname"
#    default="chewfargen.yourdomain.com"
#    example="hillbilly.yourdomain.com">

## Timezone Option
#<udf name="pinch_timezone" label="Your server timezone"
#    default="Australia/NSW"
#    example="America/Chicago">

## Custom SSH Option
#<udf name="pinch_ssh_port" label="Set your SSH port"
#    default="3636"
#    example="4914">

## New Root User
#<udf name="root_user" label="Enter the username of the new root user"
#    default="sudoninja"
#    example="wackytubeman">

## New Root User Password
#<udf name="root_password" label="Enter the password of the new root user (superuser)">

## MariaDB Root Password
#<udf name="mariadb_root_password" label="Enter the root password for your MariaDB server">

(

# Retrieve Pinch Library
source <ssinclude StackScriptID="6088">

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
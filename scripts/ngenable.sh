#!/bin/bash -e

#
# Pinch Nginx Enable
# Enables a Website Configuration in Nginx
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

if [[ -z "$1" ]];
	then 
		echo "Please enter the name of the site configuration file to enable, i.e. n2enable default.conf";
	else

		echo "Enabled site configuration: $1";
		service nginx reload
fi
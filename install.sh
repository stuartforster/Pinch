#!/bin/bash -e

#
# Pinch
# Generic Controller for Pinch
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

{

# Get Pinch Source Directory
PARAM_SRC_DIR=$(pwd)

# Include Pinch Files
. ${PARAM_SRC_DIR}/settings.sh

for includes in ${PARAM_SRC_DIR}/includes/*
do
	. $includes
done

for addons in ${PARAM_SRC_DIR}/addons/*
do
	. $addons
done

# Run Pinch Checks & Preparation
pinch_check;
pinch_prepare;

# Run Pinch Installers (in Order)
pinch_nginx;
pinch_php;
pinch_apc;
pinch_mariadb;

# Check Pinch Installed Succesfully
pinch_success

} 2>&1 | tee -a ${PARAM_LEMP_LOG}

exit
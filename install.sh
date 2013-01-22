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

# Include Pinch Build Scripts
. ${PARAM_SRC_DIR}/settings.sh
. ${PARAM_SRC_DIR}/includes/functions.sh
. ${PARAM_SRC_DIR}/includes/setup.sh

# Check Pinch Compatability
pinch_check;

# Run Pinch Addons
for file in "${PARAM_SRC_DIR}/addons" ; do
  . ${file}
done

# Run Pinch Configuration Scripts
for file in "${PARAM_SRC_DIR}/scripts" ; do
  . ${file}
done

# Check Pinch Succesfull Install
pinch_success

} 2>&1 | tee -a ${PARAM_LEMP_LOG}

exit
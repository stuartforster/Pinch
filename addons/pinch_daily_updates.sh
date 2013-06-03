#!/bin/bash -x

#
# drewsymo/Pinch
# Cron Job to Check for System Updates with Email Notifications
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
#

# Global Settings
YUMDATA=`mktemp`

# Delivery Settings
# Email can be changed to personal email, e.g. myemail@gmail.com
EMAIL="root"
FROM=`hostname`

yum check-update >& ${YUMDATA}
YUMSTATUS="${?}"

if [ -f /var/lock/subsys/yum ]; then

	SUBJECT="Yum Check Failed"
	MESSAGE="We noticed Yum was running when we attempted to initiate the check, as such, the check was aborted. Will try again tomorrow."

	else

		if [[ ${YUMSTATUS} -eq "100" ]]; then
			SUBJECT="Updates Available"
			MESSAGE="We found updates on your system (${HOSTNAME}). You can update your system by running yum-update."

		elif [[ ${YUMSTATUS} -eq "0" ]]; then
			SUBJECT="No Updates Available"
			MESSAGE="We didn't find any updates available on your system (${HOSTNAME})."

		else
			SUBJECT="Recieved Strange Return Code."
			MESSAGE="We've recieved a strange return code from the yum-check. Perhaps you should manually check for updates."
			
		fi

fi

YUMMESSAGE=`cat ${YUMDATA}`

# Compile & Send Email
sendmail -t <<EOF
To: ${EMAIL}
Subject: ${MESSAGE}
From: ${FROM}

${MESSAGE}

${YUMMESSAGE}

EOF
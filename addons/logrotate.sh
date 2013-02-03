#
# Pinch Logrotate
# Configures Logrotate for Selected Addons
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

function pinch_logrotate() {
	echo "${PARAM_NGINX_HTTP_LOG} {monthly copytruncate rotate 4 compress}" > /etc/logrotate.d/nginx
	echo "${PARAM_NGINX_ERROR_LOG} {monthly copytruncate rotate 4 compress}" > /etc/logrotate.d/nginx
}
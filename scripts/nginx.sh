#
# Pinch Nginx Configuration
# Configures Nginx for Development Use
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

# Backup NGINX Configuration File
cp ${PARAM_NGINX_PREFIX}/nginx.conf nginx.conf.backup

# Create Sites Enabled / Available Directories
mkdir ${PARAM_NGINX_PREFIX}/sites-enabled
mkdir ${PARAM_NGINX_PREFIX}/sites-available

# Create Site Home Directories
mkdir $PARAM_NGINX_SITES/default

# Populate Default Site (Optional)
touch $PARAM_NGINX_SITES/default/index.php && echo "<?php phpinfo(); ?>" > $PARAM_NGINX_SITES/default/index.php

# Insert Server Configuration File
# Credit to ghostdog74 - http://nixcraft.com/shell-scripting/14056-sed-insert-line-before-final-closing-symbol.html
awk -vt="include ${PARAM_NGINX_PREFIX}/sites-enabled/*" '{a[NR]=$0} /}/{i=NR}
END{
    for(o=1;o<=NR;o++){
        if (o==i){   print "${PARAM_NGINX_PREFIX}/sites-enabled/*"; print a[o]
        }else{ print a[o]  }
    }
}' ${PARAM_NGINX_PREFIX}/nginx.conf.backup > ${PARAM_NGINX_PREFIX}/nginx.conf

# Create Default Site in /sites-enabled/
cp nginx/default ${PARAM_NGINX_PREFIX}/sites-enabled/default

chown -R ${PARAM_NGINX_USER}:${PARAM_NGINX_USER} ${PARAM_NGINX_PREFIX}

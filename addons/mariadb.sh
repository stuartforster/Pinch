#!/bin/bash -e

#
# Pinch MariaDB Addon
# Deploys MariaDB
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

function pinch_mariadb() {

messenger "Downloading & Compiling MariaDB"

cd ${PARAM_LEMP_FILES}
pinch_url_exists https://downloads.mariadb.org/f/mariadb-${PARAM_MARIADB_VERSION}/kvm-tarbake-jaunty-x86/mariadb-${PARAM_MARIADB_VERSION}.tar.gz/from/http:/mirror.aarnet.edu.au/pub/MariaDB
tar -xvf mariadb-${PARAM_MARIADB_VERSION}.tar.gz
cd mariadb-${PARAM_MARIADB_VERSION}

cmake -DCMAKE_INSTALL_PREFIX=${PARAM_MARIADB_PREFIX} \
-DMYSQL_DATADIR=/var/lib/mysql \
-DSYSCONFDIR=${PARAM_MARIADB_PREFIX} \
-DINSTALL_PLUGINDIR=${PARAM_MARIADB_PREFIX}/lib/mysql/plugin

make && make install

useradd -M ${PARAM_MARIADB_USER}

# Symlink for MariaDB scripts
ln -s ${PARAM_MARIADB_PREFIX}/bin/* /usr/bin/

# Populate Database
cd ${PARAM_MARIADB_PREFIX}

scripts/mysql_install_db --user=${PARAM_MARIADB_USER} \
--datadir=/var/lib/mysql/

# Create upstart script
cp support-files/mysql.server /etc/init.d/

# Copy medium 32 - 128MB RAM configuration file for MariaDB
cp support-files/my-medium.cnf /etc/my.cnf

# Ensure MariaDB Runs on Start
chkconfig --add mysql.server && chkconfig mysql.server on

chown -R ${PARAM_MARIADB_USER}:${PARAM_MARIADB_USER} ${PARAM_MARIADB_PREFIX}

chmod +x /etc/init.d/mysql.server

/etc/init.d/mysql.server start

sleep 5

}

pinch_mariadb
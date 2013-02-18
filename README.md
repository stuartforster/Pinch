# Pinch

Intelligent Stack Scripts for CentOS Linux

## Installation

Pinch is a pinch to install, simply execute the following commands to get started:

	$ yum install -y git
	$ git clone git://github.com/drewsymo/Pinch.git
	$ cd Pinch/vanilla-lemp && bash install.sh

If you're on Linode, you can simply rebuild your instance with the `Pinch-installer` [stackscript](www.linode.com/stackscripts/).

## Features

* Installs a LEMP stack (PHP-FPM, MariaDB, APC, Nginx and Varnish Cache) via Yum
* Configures Varnish Cache with Nginx out-of-the-box
* Sets your hostname, timezone and installs essential tools
* Uses GoogleDNS with Level3 tertiary resolver
* Intelligentelly configures Nginx based on CPU cores
* Sets Varnish memory allocation percentage based on total memory
* Retrieves MariaDB server.cnf based on total memory
* Sets MariaDB root password and removes testing user / tables
* Creates a daily cron with email notifications for available Yum updates
* Secures your system via the following methods:
	* Creates privledged sudo user
	* Disable SSH root logins
	* Disables UseDNS
	* Change default SSH port
	* Enables SElinux
	* Firewall via iptables
	* Sets common network security parameters
	* Disables IPv6
	* Creates unprivledged www-data user for lemp components

## Author

**Drew Morris**

+ [Blog](http://drewsymo.com)
+ [Twitter](http://twitter.com/drewsymo)
+ [Google+](https://plus.google.com/u/0/114153589610660530694)
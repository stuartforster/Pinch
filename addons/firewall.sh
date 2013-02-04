#!/bin/bash -e

#
# Pinch Firewall Addon
# Configures Pinch IPTABLES
#
# @package Pinch 2.0
# @since Pinch 1.0
# @author Drew Morris
# @license http://opensource.org/licenses/MIT
#

function pinch_firewall() {

messenger "Configuring Firewall to Only Allow HTTP, SSH + SSH (Alternative) & SSL"

# Start iptables and Flush

iptables -F
iptables -t nat -F
iptables -X
iptables -P FORWARD DROP
iptables -P INPUT   DROP
iptables -P OUTPUT  ACCEPT

# SSH Traffic (Remove This)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# SSH Traffic
iptables -A INPUT -p tcp --dport 3636 -j ACCEPT

# HTTP Traffic
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# HTTPS (SSL) Traffic
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

#loopback
iptables -A INPUT -i lo -p all -j ACCEPT

}
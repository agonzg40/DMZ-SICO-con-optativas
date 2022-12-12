#!/bin/bash

#Angel Gonzalez Gonzalez
#71468965F
#script for the DMZ configuration

ip route replace default via 10.5.1.1 dev eth0

/etc/init.d/apache2 start

/etc/init.d/fail2ban start

/usr/sbin/sshd -D
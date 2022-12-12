#!/bin/bash

#Angel Gonzalez Gonzalez
#71468965F
#script for the external configuration


ip route replace default via 10.5.0.1 dev eth0

/etc/init.d/apache2 start

/usr/sbin/sshd -D
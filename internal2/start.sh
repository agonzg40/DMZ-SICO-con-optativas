#!/bin/bash

#Angel Gonzalez Gonzalez
#71468965F
#script for the internal2 configuration


ip route replace default via 10.5.2.1 dev eth0



/usr/sbin/sshd -D
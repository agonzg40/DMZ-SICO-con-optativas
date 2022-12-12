#!/bin/bash

#Angel Gonzalez Gonzalez
#71468965F
#script for the firewall configuration


echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

#enable input traffic of loopback
iptables -A INPUT -i lo -j ACCEPT

#enable input traffic of established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#enable input traffic of icmp echo request
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

#enable conexion with TCP, UDP and ICMP protocols
iptables -A FORWARD -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

#enable a range of IP 10.5.20.0/24 with protocols TCP, UDP and ICMP protocols
iptables -A FORWARD -i eth2 -o eth1 -p tcp -s 10.5.2.0/24 -j ACCEPT

iptables -A FORWARD -i eth2 -o eth1 -p udp -s 10.5.2.0/24 -j ACCEPT

iptables -A FORWARD -i eth2 -o eth1 -p icmp -s 10.5.2.0/24 -j ACCEPT

#All the packets that leave fw by the external interface and come from the internal network must change its IP
iptables -t nat -A POSTROUTING -o eth1 -s 10.5.2.0/24 -j SNAT --to 10.5.0.1

#Accept TCP access by any machine to the dmz network exclusively with the HTTP service
iptables -A FORWARD -d 10.5.1.20 -p tcp --dport 80 -j ACCEPT

#Accept TCP access by any machine to the dmz network exclusively with the HTTPS service
iptables -A FORWARD -d 10.5.1.20 -p tcp --dport 443 -j ACCEPT

#Acces SSH from int1 to dmz
iptables -A FORWARD -p tcp --dport 22 -s 10.5.2.20 -d 10.5.1.20 -j ACCEPT

iptables -A FORWARD -p tcp -s 10.5.2.20 -d 10.5.1.20 --dport 2222 -j ACCEPT

/usr/sbin/sshd -D
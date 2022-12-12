# Práctica configuración DMZ de Sistemas Confiables hecha por Ángel González González
======

**Esta entrega consiste en:**
	- Un archivo docker-compose.yml: Contiene la creación de todas las máquinas así como su configuración básica.
	- Un directorio por cada máquina, en cada directorio hay dos archivos, el Dockerfile y el start.sh.
	- Dockerfile: Archivo que contiene las configuraciones de la máquina.
	- start.sh: Script utilizado para lanzar diferentes procesos.

**Video de la práctica sin optativas:**
https://drive.google.com/file/d/1YAymm8DtqmHxart4Fsw2CHC3Vpu7hd5x/view?usp=sharing

**Github de la práctica sin optativas por si hay algún problema en la descarga de agora:**
https://github.com/agonzg40/SICO-DMZ-sin-optativas

**Video de la práctica con optativas:**
https://drive.google.com/file/d/1XiDX8Bg-4sYHgDHWLB6e5qPvnzVhakT_/view?usp=sharing

**Github de la práctica con optativas por si hay algún problema en la descarga de agora:**
https://github.com/agonzg40/DMZ-SICO-con-optativas

**Usuario utilizado en la práctica sin optativas:**

root:root

## Las salidas de los comandos ip address e ip route son las siguientes:

**dmz:**
-ip address:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
231: eth0@if232: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:01:14 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.1.20/24 brd 10.5.1.255 scope global eth0
       valid_lft forever preferred_lft forever 
```


-ip route:
```
default via 10.5.1.1 dev eth0
10.5.1.0/24 dev eth0 proto kernel scope link src 10.5.1.20
```

**external:**
-ip address:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
235: eth0@if236: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:00:14 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.0.20/24 brd 10.5.0.255 scope global eth0
       valid_lft forever preferred_lft forever
```


-ip route:
```
default via 10.5.0.1 dev eth0
10.5.0.0/24 dev eth0 proto kernel scope link src 10.5.0.20
```

**fw:**
-ip address:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
223: eth0@if224: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:01:01 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.1.1/24 brd 10.5.1.255 scope global eth0
       valid_lft forever preferred_lft forever
225: eth2@if226: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:02:01 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.2.1/24 brd 10.5.2.255 scope global eth2
       valid_lft forever preferred_lft forever
227: eth1@if228: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:00:01 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.0.1/24 brd 10.5.0.255 scope global eth1
       valid_lft forever preferred_lft forever
```

-ip route:
```
default via 10.5.1.254 dev eth0
10.5.0.0/24 dev eth1 proto kernel scope link src 10.5.0.1
10.5.1.0/24 dev eth0 proto kernel scope link src 10.5.1.1
10.5.2.0/24 dev eth2 proto kernel scope link src 10.5.2.1
```

**internal1:**
-ip address:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
229: eth0@if230: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:02:14 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.2.20/24 brd 10.5.2.255 scope global eth0
       valid_lft forever preferred_lft forever
```


-ip route:
```
default via 10.5.2.1 dev eth0
10.5.2.0/24 dev eth0 proto kernel scope link src 10.5.2.20
```

**internal2:**
-ip address:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
233: eth0@if234: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:0a:05:02:15 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.5.2.21/24 brd 10.5.2.255 scope global eth0
       valid_lft forever preferred_lft forever
```


-ip route:
```
default via 10.5.2.1 dev eth0
10.5.2.0/24 dev eth0 proto kernel scope link src 10.5.2.21
```

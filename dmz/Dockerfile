#Angel Gonzalez Gonzalez
#71468965F
#Dockerfile for the DMZ configuration



FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y openssh-server net-tools iputils-ping traceroute nano iptables iptables-dev iproute2 pkg-config tcpdump nmap apache2 fail2ban libpam-google-authenticator openssl
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
#RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#Create new user
RUN useradd -m -s /bin/bash userAccess || true
RUN echo 'userAccess:enter' | chpasswd

#Allow the 2222 port
RUN sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config

#Allow access with password
RUN sed -ri 's/^#?PasswordAuthentication\s+.*/#PasswordAuthentication yes/' /etc/ssh/sshd_config

#Deny access with empty password
RUN sed -ri 's/^#?PermitEmptyPasswords\s+.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config

#Create public key
RUN useradd -m -s /bin/bash pkey || true
RUN echo 'pkey:enter' | chpasswd

#Allow access with public key
RUN sed -ri 's/^#?PubkeyAuthentication\s+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

#Max intents allowed to login is 2
RUN sed -ri 's/^#?MaxAuthTries\s+.*/MaxAuthTries 3/' /etc/ssh/sshd_config

#Use personaliced banner
COPY ./banner.txt /etc/motd

#Creating files to use fail2ban
RUN touch /var/log/auth.log

#RUN service fail2ban start

#Remove a file that can cause problems
#RUN rm -r /var/run/fail2ban/fail2ban.sock

#Iniciating fail2ban
#RUN fail2ban-client start

#To make SSH use the Google Authenticator PAM module
#RUN echo "@include common-password" >> /etc/pam.d/sshd
RUN echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd

#RUN echo "auth required pam_permit.so" >> /etc/pam.d/sshd

#RUN sed -ri 's/^#?AuthenticationMethods\s+.*/AuthenticationMethods publickey,keyboard-interactive/' /etc/ssh/sshd_config


#Change ChallengeResponseAuthentication from no to yes
RUN sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config

#Accept https
RUN a2enmod ssl
RUN a2enmod rewrite

# add override to htaccess
RUN echo '<Directory /var/www/html> \n\
  AllowOverride All \n\
  </Directory>' >>/etc/apache2/apache2.conf

#Creating certificates
RUN mkdir /etc/apache2/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/certs/apache.key -out /etc/apache2/certs/apache.crt -subj "/C=ES/ST=Leon/L=Leon/O=Unileon/CN=10.5.1.20"

#Adding certificates
RUN echo ' \n\
  <VirtualHost *:443> \n\
  ServerAdmin angel@localhost \n\
  DocumentRoot /var/www/html \n\ 
  SSLEngine on \n\
  SSLCertificateFile /etc/apache2/certs/apache.crt \n\
  SSLCertificateKeyFile /etc/apache2/certs/apache.key \n\ 
  </VirtualHost> ' >> /etc/apache2/sites-enabled/000-default.conf

RUN echo '<html>\<Hola mundo desde la primera practica de Sistemas Confiables!". \</html>' >/var/www/html/index.html

RUN mkdir /root/.ssh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 22
EXPOSE 2222
EXPOSE 80
EXPOSE 443
COPY ./start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]
# Instalado nexus
 ```
 apt-get update
 apt-get install --no-install-recommends -y openjdk-8-jre-headless nginx unzip curl net-tools
 ```
 
##dpkg-reconfigure tzdata

 ```
 cd /tmp
 curl -#OL -k https://download.sonatype.com/nexus/3/latest-unix.tar.gz
 tar -xvzf latest-unix.tar.gz
 rm -f latest-unix.tar.gz
 mv /tmp/nexus-* /opt/nexus

 useradd -U -M -s /bin/nologin -d /opt/nexus nexus
 mkdir /opt/sonatype-work
 chown -R nexus:nexus /opt/nexus
 chown -R nexus:nexus /opt/sonatype-work
 sed -i "s|run_as_user=''|run_as_user='nexus'\nNEXUS_HOME='/opt/nexus'|" /opt/nexus/bin/nexus
 echo 'run_as_user="nexus"' > /opt/nexus/bin/nexus.rc 

 echo '[Unit]
 Description=nexus service
 After=network.target
 [Service]
 Type=forking
 WorkingDirectory=/opt/nexus
 LimitNOFILE=65536
 ExecStart=/opt/nexus/bin/nexus start
 ExecStop=/opt/nexus/bin/nexus stop
 User=nexus
 Restart=on-abort
 [Install]
 WantedBy=multi-user.target' > /etc/systemd/system/nexus.service

 systemctl daemon-reload
 systemctl enable nexus.service
 systemctl start nexus.service
```
Para verificar o log da instalação:

 ```tail -f /opt/sonatype-work/nexus3/log/nexus.log```

No log vai aparecer a seguinte mensagens quando estiver inicializado. 
A primeira inicialização demora uns 30 minutos
   Started Sonatype Nexus OSS 3.41.0-01


 
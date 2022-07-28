FQDN=nexus.wfs.com
DOMAIN=wfs.com.br

openssl req -x509 -newkey rsa:4096 -sha256 -days 10950 -nodes \
  -keyout /etc/ssl/private/nexus.key -out /etc/ssl/private/nexus.crt \
  -subj "/C=BR/ST=DF/L=Brasilia/O=wfs/CN=$DOMAIN" \
  -addext "subjectAltName=DNS:*.$DOMAIN"

chmod 600 /etc/ssl/private/nexus.crt /etc/ssl/private/nexus.key
cp /etc/ssl/private/nexus.crt /usr/local/share/ca-certificates/
update-ca-certificates

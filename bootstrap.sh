#!/bin/bash

apt-get -y update
apt-get -y install default-jre

# Elasticsearch
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | tee /etc/apt/sources.list.d/elasticsearch.list
apt-get -y update
apt-get -y install elasticsearch
echo '
network.host: localhost' >> /etc/elasticsearch/elasticsearch.yml
update-rc.d elasticsearch defaults 95 10
service elasticsearch restart

# Kibana
cd ~
curl -o kibana-4.1.1-linux-x64.tar.gz https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz
tar -zxvf kibana-4.1.1-linux-x64.tar.gz
rm -f kibana-4.1.1-linux-x64.tar.gz
mv kibana-4.1.1-linux-x64 kibana
perl -pi -e 's/host: "0\.0\.0\.0"/host: "localhost"/g' kibana/config/kibana.yml
mkdir -p /opt/kibana
cp -R ~/kibana/* /opt/kibana/
rm -rf ~/kibana
cat /vagrant/kibana/service > /etc/init.d/kibana4
chmod +x /etc/init.d/kibana4
update-rc.d kibana4 defaults 96 9
service kibana4 start

# Nginx (Kibana forward)
apt-get -y install nginx apache2-utils
htpasswd -bc /etc/nginx/htpasswd.users kibana secretpassword
cat /vagrant/nginx/kibana > /etc/nginx/sites-available/kibana
ln -s /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/kibana
unlink /etc/nginx/sites-enabled/default 
service nginx restart

# Logstash
echo 'deb http://packages.elasticsearch.org/logstash/1.5/debian stable main' | tee /etc/apt/sources.list.d/logstash.list
apt-get -y update
apt-get -y install logstash

ln -s /vagrant/logstash/lumberjack-input.conf /etc/logstash/conf.d/01-lumberjack-input.conf
ln -s /vagrant/logstash/syslog.conf /etc/logstash/conf.d/10-syslog.conf
ln -s /vagrant/logstash/apache-access.conf /etc/logstash/conf.d/20-apache-access.conf
ln -s /vagrant/logstash/lumberjack-output.conf /etc/logstash/conf.d/99-lumberjack-output.conf

mkdir -p /etc/pki/tls/certs /etc/pki/tls/private

sed -i "225i\\
subjectAltName = IP: 192.168.50.120" /etc/ssl/openssl.cnf

cd /etc/pki/tls
openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt

service logstash restart
update-rc.d logstash defaults 97 8

#!/bin/bash

apt-get -y update
apt-get -y install default-jre

cd ~
mkdir app

curl -o logstash-1.5.3.tar.gz https://download.elastic.co/logstash/logstash/logstash-1.5.3.tar.gz
curl -o elasticsearch-1.7.1.tar.gz https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz
curl -o kibana-4.1.1-linux-x64.tar.gz https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz

tar -zxvf logstash-1.5.3.tar.gz
tar -zxvf elasticsearch-1.7.1.tar.gz
tar -zxvf kibana-4.1.1-linux-x64.tar.gz

rm -f logstash-1.5.3.tar.gz
rm -f elasticsearch-1.7.1.tar.gz
rm -f kibana-4.1.1-linux-x64.tar.gz

mv logstash-1.5.3 app/logstash
mv elasticsearch-1.7.1 app/elasticsearch
mv kibana-4.1.1-linux-x64 app/kibana

cd app

echo 'input {
    file {
        path => "/vagrant/access.log"
        start_position => beginning
    }
}
filter {
    grok {
        match => { "message" => "%{COMBINEDAPACHELOG}"}
    }
    geoip {
        source => "clientip"
    }
    useragent {
        source => "agent"
        target => "useragent"
    }
}
output {
    elasticsearch {
        protocol => "http"
        host => "localhost"
        user => "logstash"
        password => "batman"
    }
    stdout { codec => rubydebug }
}' > ~/app/logstash.conf

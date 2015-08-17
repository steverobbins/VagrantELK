#!/bin/bash

~/app/elasticsearch/bin/elasticsearch > ~/app/log/elasticsearch.log 2>&1 &
sleep 5
~/app/kibana/bin/kibana > ~/app/log/kibana.log 2>&1 &
sleep 5
~/app/logstash/bin/logstash -f /vagrant/logstash-apache.conf > ~/app/log/logstash.log 2>&1 &

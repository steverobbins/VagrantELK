#!/bin/bash

~/app/elasticsearch/bin/elasticsearch > /dev/null 2>&1 &
~/app/kibana/bin/kibana > /dev/null 2>&1 &
~/app/logstash/bin/logstash -f ~/app/logstash.conf > /dev/null 2>&1 &


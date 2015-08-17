Vagrant Box for Elasticsearch, Kibana, and Logstash
===

# Installation

```
git clone https://github.com/steverobbins/VagrantLogstash.git
cd VagrantLogstash
vagrant up
```

Once the installation is complete you should be able to access Kibana at
[http://192.168.50.120:5601/](http://192.168.50.120:5601/).

Use the following credentials to login:

* User: `admin`
* Password: `batman`

To get started, an example Apache `access.log` and Logstash configuration is
included.  Try adding your own `access.log` for more interesting metrics.

# More

This implementation follows the [Logstash: 0-60 in 60](https://www.elastic.co/webinars/logstash-0-60-in-60)
webinar.  I recommend watching it to get an understanding of what's happening
in the background, as well as setting up your first dashboards.

Vagrant Box for Elasticsearch, Logstash, and Kibana
===

# Installation

```
git clone https://github.com/steverobbins/VagrantELK.git
cd VagrantELK
vagrant up
```

Once the installation is complete you should be able to access Kibana at
[http://192.168.50.120/](http://192.168.50.120/).

Use the following credentials to login:

* User: `kibana`
* Password: `secretpassword`

To get started, an example Apache `access.log` and Logstash configuration is
included.  Try adding your own data `sample/apache-access.log` for more interesting metrics.

# More

* [https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-4-on-ubuntu-14-04](https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-4-on-ubuntu-14-04)
* [https://www.elastic.co/webinars/logstash-0-60-in-60](https://www.elastic.co/webinars/logstash-0-60-in-60)

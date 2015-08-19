Vagrant Box for Elasticsearch, Logstash, and Kibana
===

![screenshot](https://i.imgur.com/YcUS7ff.png)

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

You will need to forward your logs to Kibana in order to start seeing data.

*Copied from [this article](https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-4-on-ubuntu-14-04).*

> ### Copy SSL Certificate and Logstash Forwarder Package
> 
> On Logstash Server, copy the SSL certificate to Client Server (substitute the client server's address, and your own login):
> 
> ```
> scp /etc/pki/tls/certs/logstash-forwarder.crt user@client_server_private_address:/tmp
> ```
> 
> After providing your login's credentials, ensure that the certificate copy was successful. It is required for communication between the client servers and the Logstash server.
> 
> ### Install Logstash Forwarder Package
> 
> On Client Server, create the Logstash Forwarder source list:
> 
> ```
> echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | tee /etc/apt/sources.list.d/logstashforwarder.list
> ```
> 
> It also uses the same GPG key as Elasticsearch, which can be installed with this command:
> 
> ```
> wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
> ```
> 
> Then install the Logstash Forwarder package:
> 
> ```
> apt-get -y update
> apt-get -y install logstash-forwarder
> ```
> 
> *Note: If you are using a 32-bit release of Ubuntu, and are getting an "Unable to locate package logstash-forwarder" error, you will need to install Logstash Forwarder manually.*
> 
> Now copy the Logstash server's SSL certificate into the appropriate location (`/etc/pki/tls/certs`):
> 
> ```
> mkdir -p /etc/pki/tls/certs
> cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/
> ```
> 
> ### Configure Logstash Forwarder
> 
> On Client Server, create and edit Logstash Forwarder configuration file, which is in JSON format:
> 
> ```
> vim /etc/logstash-forwarder.conf
> ```
> 
> Under the network section, add the following lines into the file, substituting in your Logstash Server's private address for `logstash_server_private_address`:
> 
> ```
>     "servers": [ "logstash_server_private_address:5000" ],
>     "timeout": 15,
>     "ssl ca": "/etc/pki/tls/certs/logstash-forwarder.crt"
> ```
> 
> Under the files section (between the square brackets), add the following lines,
> 
> ```
>     {
>         "paths": [
>             "/var/log/syslog",
>             "/var/log/auth.log"
>         ],
>         "fields": { "type": "syslog" }
>     }
> ```
> 
> Save and quit. This configures Logstash Forwarder to connect to your Logstash Server on port `5000` (the port that we specified an input for earlier), and uses the SSL certificate that we created earlier. The paths section specifies which log files to send (here we specify syslog and auth.log), and the type section specifies that these logs are of type `syslog` (which is the type that our filter is looking for).
> 
> Note that this is where you would add more files/types to configure Logstash Forwarder to other log files to Logstash on port `5000`.
> 
> Now restart Logstash Forwarder to put our changes into place:
> 
> ```
> service logstash-forwarder restart
> ```
> 
> Now Logstash Forwarder is sending syslog and auth.log to your Logstash Server! Repeat this section for all of the other servers that you wish to gather logs for.

# More

* [https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-4-on-ubuntu-14-04](https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-4-on-ubuntu-14-04)
* [https://www.elastic.co/webinars/logstash-0-60-in-60](https://www.elastic.co/webinars/logstash-0-60-in-60)

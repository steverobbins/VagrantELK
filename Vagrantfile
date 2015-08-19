# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box       = "ubuntu/trusty64"
  config.vm.host_name = "elk"  
  config.vm.provision     :shell, :path => "bootstrap.sh"
  config.vm.network       :forwarded_port, guest: 80, host: 8090
  config.vm.network       "private_network", ip: "192.168.50.120"
  config.vm.provider :virtualbox do |vb|
    vb.customize [
        "modifyvm", :id,
        "--memory", "4096",
    ]
    vb.name = "elk"
  end
end

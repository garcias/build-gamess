# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "10.0.1.222"
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.vm.provider :virtualbox do |v|
    v.name = "GAMESS"
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.provision "shell", privileged: true, inline: $GAMESS_PREP
  config.vm.provision "shell", privileged: false, inline: $GAMESS_CONFIG
  config.vm.provision "shell", privileged: false, inline: $GAMESS_TEST

end

$GAMESS_PREP = <<SCRIPT

echo "~~~ GAMESS_PREP ~~~
echo "not implemented yet"

SCRIPT


$GAMESS_CONFIG = <<SCRIPT

echo "~~~ GAMESS_PREP ~~~
echo "not implemented yet"

SCRIPT


$GAMESS_TEST = <<SCRIPT

echo "~~~ GAMESS_PREP ~~~
echo "not implemented yet"

SCRIPT

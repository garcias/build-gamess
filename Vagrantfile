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
  config.vm.provision "shell", privileged: false, inline: $GAMESS_INSTALL

end

$GAMESS_PREP = <<SCRIPT

msg1 () {
  echo "=== "$1" ==="
}

msg2 () {
  echo "~~~ "$1" ~~~"
}

msg1 "GAMESS_PREP"
msg2 "Updating apt-get"
apt-get update -qq
msg2 "Installing build tools"
apt-get install -y gfortran csh xauth git curl
msg2 "Installing atlas math libraries"
apt-get install -y libblas-dev libatlas-base-dev
echo "kernel.shmmax = 268435456" >> /etc/sysctl.conf

SCRIPT


$GAMESS_INSTALL = <<SCRIPT

msg1 () {
  echo "=== "$1" ==="
}

msg2 () {
  echo "~~~ "$1" ~~~"
}

INSTALL_DIR=~/
ATLAS_DIR=/usr/lib/atlas-base

msg1 "Installing GAMESS source code"
msg2 "Getting gfortran version"
msg2 "gfortran is version $(gfortran -dumpversion)"
msg2 "Extracting source code from /vagrant"
cd $INSTALL_DIR
cp /vagrant/gamess-current.tar.gz ./
tar -xzf gamess-current.tar.gz
rm gamess-current.tar.gz

cp /vagrant/postinstall ./
chmod u+x postinstall

SCRIPT


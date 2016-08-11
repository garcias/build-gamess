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

# Using 3/4 GB for shared memory
SHARED_MAX=$((768 * 1024 * 1024))
SHARED_ALL=$((768 * 1024 * 1024 / 4096))

echo "=== Preparing system for GAMESS install ==="
echo "Updating apt-get"
apt-get update -qq
echo "Installing build tools"
apt-get install -y gfortran csh xauth git curl
echo "Installing atlas math libraries"
apt-get install -y libblas-dev libatlas-base-dev
echo "Setting shmmax to $SHARED_MAX"
echo "Setting shmall to $SHARED_ALL"
echo "kernel.shmmax = $SHARED_MAX" >> /etc/sysctl.conf
echo "kernel.shmall = $SHARED_ALL" >> /etc/sysctl.conf
sysctl -p
echo "Installing Java runtime and Jmol"
apt-get install -y default-jre jmol
echo "Installing OpenBabel"
apt-get install -y openbabel

SCRIPT


$GAMESS_INSTALL = <<SCRIPT

cd ~
cp /vagrant/gamess-current.tar.gz ./
cp /vagrant/postinstall ./
cp /vagrant/runtests ./
chmod u+x postinstall runtests

SCRIPT


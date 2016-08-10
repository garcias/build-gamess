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

SHARED_MEMORY=268435456

echo "=== Preparing system for GAMESS install ==="
echo "Updating apt-get"
apt-get update -qq
echo "Installing build tools"
apt-get install -y gfortran csh xauth git curl
echo "Installing atlas math libraries"
apt-get install -y libblas-dev libatlas-base-dev
echo "Setting shared memory limit to $SHARED_MEMORY"
echo "kernel.shmmax = "$SHARED_MEMORY >> /etc/sysctl.conf
sysctl -p
cat /etc/sysctl.conf | grep -i "shmmax"
echo "Installing Java runtime and Jmol"
apt-get install -y default-jre jmol
echo "Installing OpenBabel"
apt-get install -y openbabel

SCRIPT


$GAMESS_INSTALL = <<SCRIPT

INSTALL_DIR=~/
ATLAS_DIR=/usr/lib/atlas-base

echo "=== Installing GAMESS source code ==="
echo "Getting gfortran version"
echo "gfortran is version $(gfortran -dumpversion)"
echo "Extracting source code from /vagrant"
cd $INSTALL_DIR
cp /vagrant/gamess-current.tar.gz ./
tar -xzf gamess-current.tar.gz
rm gamess-current.tar.gz

cp /vagrant/postinstall ./
chmod u+x postinstall

echo "Remember to run ./postinstall to configure and build GAMESS"

SCRIPT


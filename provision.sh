#!/usr/bin/env bash
# -*- coding: utf-8 -*-

export DEBIAN_FRONTEND=noninteractive

aptitude update
aptitude purge -y chef chef-zero puppet puppet-common
aptitude dist-upgrade -y
ln -sf /vagrant /home/vagrant/
mkdir -p /var/www
ln -sf /vagrant/pythonkc_site /var/www/pythonkc_site

# install pip the hard way
# chip, please fix. :)
mkdir /home/vagrant/tmp
cd /home/vagrant/tmp
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
python3 ez_setup.py
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python3 get-pip.py

if [[ -z "$(which ansible)" ]]; then
    echo "Installing Ansible..."
    aptitude install -y python3 python3-dev python3-pip ansible
fi

cd /home/vagrant/vagrant/ansible
ansible-playbook vagrant.yml

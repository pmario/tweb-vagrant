# -*- mode: ruby -*-
# vi: set ft=ruby :

# tweb config: V 0.0.2 - 2013.08.10
# by: pmario

BOX_NAME = ENV['BOX_NAME'] || "precise"
BOX_URI = ENV['BOX_URI'] || "http://files.vagrantup.com/precise32.box"

# We need to create a private network, because of windows
PRIVATE_IP = "192.168.3.10"

Vagrant.configure("2") do |config|
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

# not needed if :private_network is used.
#  config.vm.network :forwarded_port, guest: 8080, host: 8080
  
  config.vm.network :private_network, ip: PRIVATE_IP

  # Install dependencies if deployment was not done
  if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?
  
    # apt-get upgrade -y 
    # should needs to be done manually
  
    # system requirements
    pkg_cmd = "apt-get update -qq; apt-get install -q -y build-essential; "

    # Install tiddlyweb dependencies
    pkg_cmd << "apt-get install -q -y python2.7-dev python-setuptools; "
    
    # (2013.07.29) Get the latest version of pip otherwise you will get !@§$@$
    # see: https://github.com/pypa/pip/issues/986 and the fix at: https://github.com/pypa/pip/pull/992
    pkg_cmd << "easy_install pip; "

    # Install daemontools + autostart dependencies
    pkg_cmd << "apt-get install -q -y daemontools ucspi-tcp csh; "

    # Install convenience modules
    pkg_cmd << "apt-get install -q -y git-core mc htop; "

    config.vm.provision :shell, :inline => pkg_cmd

	# install mc if above command is disabled for debugging :)
	config.vm.provision :shell, :inline => "apt-get install -q -y mc; "

	# --------------------------------------------------
	# install tiddlywebwiki
	HOME = "/home/vagrant"
	SHARE_DIR = "/vagrant"
	TWEB_SERVICE_DIR = "#{HOME}/tweb/service"
	SERVICE_ASSETS_DIR = "#{SHARE_DIR}/assets/service"
	ASSETS_DIR = "#{SHARE_DIR}/assets"
	
	# root:
	config.vm.provision :shell, :inline => "pip install -U tiddlywebwiki"
	
	# vagrant: create tiddlywebwiki instance definitions
	config.vm.provision :shell, :inline => "su - vagrant -c 'cd #{SHARE_DIR}; twinstance tweb; cd tweb' "

	# root: setup autostart service directories
	config.vm.provision :shell, :inline => "mkdir /service;"
	
	# vagrant: 
	config.vm.provision :shell, :inline => "su - vagrant -c 'mkdir -p #{TWEB_SERVICE_DIR}/log' "

	# copy autostart scripts 
	cmd =	"cp #{SERVICE_ASSETS_DIR}/run #{TWEB_SERVICE_DIR}; chmod +x #{TWEB_SERVICE_DIR}/run; " \
			"cp #{SERVICE_ASSETS_DIR}/log/run #{TWEB_SERVICE_DIR}/log; chmod +x #{TWEB_SERVICE_DIR}/log/run"
	config.vm.provision :shell, :inline => cmd
	
	# root: copy svscanboot 
	cmd = "cp #{ASSETS_DIR}/svscanboot /usr/bin/svscanboot; chmod +x /usr/bin/svscanboot"
	config.vm.provision :shell, :inline => cmd

	# root: symlink the instance service dir to daemon /service dir
	cmd = "ln -s #{TWEB_SERVICE_DIR} /service/tweb"
	config.vm.provision :shell, :inline => cmd

	# add daemontools autostart line to rc.local
	config.vm.provision :shell, :path => "assets/modify.rc.local.sh"

	# --------------------------------------------------
	# add tweb.local host name to /etc/hosts file
	# This is kind of hardcore. TODO fix this
	
	config.vm.provision :shell do |s|
		s.path = "assets/modify.etc.hosts.sh"
		s.args = PRIVATE_IP
	end
  end
end


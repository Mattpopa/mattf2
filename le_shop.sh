#!/bin/bash

#sudo yum -y install npm busybox 
sudo apt-get install -y npm
pushd /var/tmp && nohup busybox httpd -f -p "${server_port}" &
~                                                                                                   
~                                                                                                   
~                

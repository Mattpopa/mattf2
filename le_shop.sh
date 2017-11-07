#!/bin/bash

#sudo yum -y install npm busybox 
sudo apt-get install -y npm
pushd ~ && wget http://emojis.slackmojis.com/emojis/images/1488512507/1804/aaw_yeah.gif && sleep 1
cat > ~/index.html << EOF
<img src="aww_yeah.gif" alt="aww yeah" style="width: 100%;">
<p> aw yeah </p>
EOF

nohup busybox httpd -f -p "${server_port}" &
~                                                                                                   
~                                                                                                   
~                

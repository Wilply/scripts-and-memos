#!/bin/bash

tee /etc/apt/sources.list.d/mongodb-org-4.2.list << EOF
deb https://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main
EOF

tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt buster main
EOF

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-get update
apt-get --assume-yes install pritunl mongodb-org-server
systemctl start mongod pritunl
systemctl enable mongod pritunl
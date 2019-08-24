#!/usr/bin/env bash

#Install & configure telegraph on debian
VERSION=$(cat /etc/os-release | grep -E "^VERSION=" | awk -F '[()]' '{print $2}')
echo "debian version : ${VERSION}"

echo "[INFO] add telegraph repo"

wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/debian ${VERSION} stable | sudo tee /etc/apt/sources.list.d/influxdb.list"

echo "[INFO] installing telegraf & tools"
sudo apt-get update && sudo atp-get install -y hddtemps lm-sensors telegraf

echo "[INFO] getting config file"
sudo wget -qO- https://raw.githubusercontent.com/Wilply/compose-files/master/04_grafana/telegraf.conf > /etc/telegraf/telegraf.conf

echo "[INFO] enable & start telegraf"
sudo systemctl enable telegraf
sudo systemctl restart telegraf
sudo systemctl status telegraf

echo "[INFO] Done."
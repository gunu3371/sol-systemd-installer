#!/bin/bash
mkdir -p /etc/sol
apt update
apt install unzip wget
cd /etc/sol
wget https://github.com/SR-G/sleep-on-lan/releases/download/1.1.1-RELEASE/SleepOnLAN-1.1.1-RELEASE.zip
unzip SleepOnLAN-1.1.1-RELEASE.zip
cp -r linux_amd64/sol /bin/
cp -r linux_amd64/sol.json .
rm -r windows_*
rm -r linux_*
rm SleepOnLAN-1.1.1-RELEASE.zip
chmod +x /bin/sol
echo """[Unit]
Description=Sleep-On-LAN daemon

[Service]
User=root
WorkingDirectory=/etc/sol/
ExecStart=/bin/sol --config /etc/sol/sol.json
Restart=always

[Install]
WantedBy=multi-user.target""" > /etc/systemd/system/sleep-on-lan.service
systemctl daemon-reload
systemctl enable sleep-on-lan.service
systemctl start sleep-on-lan.service

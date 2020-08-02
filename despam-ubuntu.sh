#!/bin/bash
echo "Turning off Ubuntu spam"
sudo sed -i 's/^ENABLED=.*/ENABLED=0/' /etc/default/motd-news

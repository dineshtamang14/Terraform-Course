#!/bin/bash

sleep 10
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install nginx vim fish unzip -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
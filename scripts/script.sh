#!/bin/bash

sudo apt update && apt install nginx -y
sudo cp -aR /tmp/index.html /var/www/html/
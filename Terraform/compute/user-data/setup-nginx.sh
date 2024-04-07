#!/bin/bash
apt-get update
apt-get install nginx -y
echo -e  " <h1>welcome to the webshite</h1> \n <h3> my hostname is $HOSTNAME </h3>" > index.html
systemctl enable nginx
systemctl start nginx

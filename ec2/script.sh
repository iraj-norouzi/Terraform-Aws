#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html 
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/metadata.html

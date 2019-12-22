#!/bin/bash

instance_name="${service_name}"

private_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
printf "127.0.0.1 localhost
127.0.1.1 "${service_name}"\n\n

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts\n" > /etc/hosts

hostname ${service_name}
printf "${service_name}" > /etc/hostname

# BUCKET

sudo apt-get update
sudo apt-get install -y awscli nginx vim

bucket_name="poc-bucket"
sudo aws s3 cp s3://${bucket_name}/files/index.html /var/www/html/index.html

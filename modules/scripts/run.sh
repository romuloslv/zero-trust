#!/usr/bin/env bash

# firewall
systemctl stop firewalld
systemctl disable firewalld

# packages
yum update
yum upgrade -y
yum install -y epel-release nc

# selinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
setenforce 1
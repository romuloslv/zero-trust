#!/usr/bin/env bash

# firewall
systemctl stop firewalld
systemctl disable firewalld

# packages
yum update
yum upgrade -y
#!/bin/bash
yum install -y deltarpm
yum update -y
yum install -y https://rdo.fedorapeople.org/rdo-release.rpm
yum install -y openstack-packstack
yum install -y epel-release erlang.x86_64
packstack --allinone


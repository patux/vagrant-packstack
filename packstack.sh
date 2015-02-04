#!/bin/bash
# if you are behind a proxy use this variable to set your proxy
# entries like: http://proxy-foo.com:3128
# proxy=http://10.0.100.1:3128
if [ "$proxy" ]; then
    [ -e /etc/environment.bk ] && cp /etc/environment.bk /etc/environment || cp /etc/environment /etc/environment.bk
    echo http_proxy=$proxy >> /etc/environment
    echo https_proxy=$proxy >> /etc/environment
    echo no_proxy=localhost,localhost.localdomain,127.0.0.1,10.0.100.1,10.0.100.11,10.0.2.15,10.0.2.2,10.0.2.3, >> /etc/environment
    [ -e /etc/yum.conf.bk ] && cp /etc/yum.conf.bk /etc/yum.conf || cp /etc/yum.conf  /etc/yum.conf.bk
    echo proxy=$proxy >> /etc/yum.conf
    source /etc/environment
fi

systemctl stop NetworkManager
systemctl disable NetworkManager
/sbin/chkconfig network on
systemctl restart network.service
yum install -y deltarpm
yum update -y
yum install -y https://rdo.fedorapeople.org/rdo-release.rpm
yum install -y openstack-packstack
yum install -y epel-release erlang.x86_64
packstack -d --answer-file=/vagrant/packstack-answers.txt
# Adding cirros image
source /etc/environment
source /root/keystonerc_admin
/usr/bin/wget -q -O /tmp/cirros-0.3.3-x86_64-disk.img http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img
/usr/bin/glance image-create --name="CirrOS 0.3.3" --disk-format=qcow2 --container-format=bare --is-public=true --file /tmp/cirros-0.3.3-x86_64-disk.img

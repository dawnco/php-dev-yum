#!/bin/bash

# date 20190920
# yum 方式安装  php7.2 redis mysql8  


rpm -ivh https://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -ivh https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm

yum install -y gd-last --enablerepo=remi
yum install -y lrzsz zip unzip
yum install -y git
yum install -y supervisor


cp -f conf/nginx.repo /etc/yum.repos.d/nginx.repo
cp -f conf/vimrc      ~/.vimrc

# 值保留10条历史
sed -i "s/HISTSIZE=1000/HISTSIZE=10/g" /etc/profile


echo "依赖安装完毕"

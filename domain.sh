#!/bin/bash

# date 20190920
# 新建站点


echo -n "site domain or name:"
read domain

echo -n "port(default 80):"
read port

echo -n "ssl(yes/no, default no):"
read ssl


if [ "${port}" = "" ]; then
    port="80"
fi

if [ "${ssl}" = "" ]; then
    ssl="no"
fi

mkdir -p /data/www/${domain}

if [ "${ssl}" = "yes" ]; then
    cp -f conf/nginx-server-ssl.conf  /etc/nginx/conf.d/${domain}-ssl.conf
    echo "upload cert to /data/cert/${domain}.{key, pem}"
fi

if [ "${ssl}" = "no" ]; then
    cp -f conf/nginx-server.conf  /etc/nginx/conf.d/${domain}.conf
fi

sed -i "s/PORT/${port}/g"  /etc/nginx/conf.d/${domain}.conf
sed -i "s/DOMAIN/${domain}/g"  /etc/nginx/conf.d/${domain}.conf

echo "OK"
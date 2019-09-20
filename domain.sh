#!/bin/bash

# date 20190920
# 新建站点


echo -n "site domain or name:"
read domain

echo -n "port:"
read port

echo -n "SSL yes/no?"
read ssl
	
mkdir -p /data/www/${domain}

if [ "${ssl}" = "yes" ]; then
    cp -f conf/nginx-server-ssl.conf  /etc/nginx/conf.d/${domain}.conf
	echo "upload cert to /data/cert/${domain}.{key, pem}"
fi

if [ "${ssl}" = "" ]; then
    cp -f conf/nginx-server.conf  /etc/nginx/conf.d/${domain}.conf
fi

sed -i "s/PORT/${port}/g"  /etc/nginx/conf.d/${domain}.conf
sed -i "s/DOMAIN/${domain}/g"  /etc/nginx/conf.d/${domain}.conf

echo "OK"
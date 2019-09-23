#!/bin/bash

# date 20190920
# yum 方式安装  php7.2 redis mysql8

yum --enablerepo=nginx -y install nginx

yum --enablerepo=remi -y install redis

yum --enablerepo=remi-php72 -y  install php php-fpm php-mcrypt php-mbstring php-redis php-mysql php-gd php-mysql php-devel php-pear php-xml php-bcmath php-zip php-swoole


yum install -y mysql mysql-server


# 配置
cp -f conf/my.conf  /etc/my.cnf
cp -f conf/www.conf /etc/php-fpm.d/www.conf



systemctl enable php-fpm
systemctl enable nginx
systemctl enable redis
systemctl enable mysqld

systemctl start php-fpm
systemctl start nginx
systemctl start redis
systemctl start mysqld


echo -e "\033[44;37m 环境安装完毕 \033[0m"

################################################################




#nginx 配置
sed -i "s#/var/log/nginx/error.log#/data/log/nginx-error.log#g" /etc/nginx/nginx.conf

mkdir -p /data/www/home
mkdir /data/www/phpMyAdmin
mkdir /data/soft 
mkdir /data/cert 
mkdir /data/log


wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.zip -O /data/soft/phpMyAdmin.zip
unzip /data/soft/phpMyAdmin.zip -d /data/www/phpMyAdmin

cp conf/nginx-server.conf  /etc/nginx/conf.d/phpMyAdmin.conf
sed -i "s/PORT/8001/g"  /etc/nginx/conf.d/phpMyAdmin.conf
sed -i "s/DOMAIN/phpMyAdmin/g"  /etc/nginx/conf.d/phpMyAdmin.conf

echo -e "\033[44;37m 配置完毕 \033[0m"


# 重启服务
systemctl restart mysqld
systemctl restart php-fpm
systemctl restart nginx

echo -e "\033[44;37m 服务已经开启 \033[0m"


#配置

# Mysql密码
echo 'mysql root password'
str=`grep 'temporary password' /data/log/mysqld.log`
pwd=${str##*: }

echo "mysql pwd: ${pwd}"
echo "copy sql"
cat <<EOF
mysql -uroot -p'$pwd'

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Q,Fflgfye6w.1';
FLUSH PRIVILEGES;

EOF


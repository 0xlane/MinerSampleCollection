#!/bin/bash

killall -9 pwnrig 2>/dev/null
killall -9 syst3m 2>/dev/null
killall -9 cnrig 2>/dev/null
kill -9 $(ps -p $(pidof nginx) 2>/dev/null| grep ' \-d' | awk -F' ' '{print $1}') 2>/dev/null

chattr -ia /etc/cron.hourly/pwnrig /etc/cron.weekly/pwnrig /etc/cron.daily/pwnrig /etc/cron.monthly/pwnrig /etc/cron.d/pwnrig 2>/dev/null
chattr -ia /etc/init.d/pwnrig /etc/rc.d/rc*.d/*pwnrig /etc/rc.d/init.d/pwnrig 2>/dev/null
chattr -ia /usr/lib/systemd/system/pwnrig* /etc/systemd/system/pwnrige* /etc/systemd/system/multi-user.target.wants/pwnrig* 2>/dev/null
chattr -ia /var/spool/cron/oracle /var/spool/cron/root /root/.bash_profile /home/oracle/.bash_profile 2>/dev/null
chattr -ia /usr/local/lib/libprocesshider.so 2>/dev/null
chattr -ia /tmp/nginx /tmp/.pwn/* /dev/shm/.nginx/sshd /bin/bprofr /bin/crondr /bin/initdr /bin/sysdr /bin/nginx 2>/dev/null
chattr -ia /tmp/.../* 2>/dev/null
chattr -ia /home/*/cnrig* 2>/dev/null

rm -rf /etc/cron.hourly/pwnrig /etc/cron.weekly/pwnrig /etc/cron.daily/pwnrig /etc/cron.monthly/pwnrig /etc/cron.d/pwnrig 2>/dev/null
rm -rf /etc/init.d/pwnrig /etc/rc.d/rc*.d/*pwnrig /etc/rc.d/init.d/pwnrig 2>/dev/null
rm -rf /usr/lib/systemd/system/pwnrig* /etc/systemd/system/pwnrige* /etc/systemd/system/multi-user.target.wants/pwnrig* 2>/dev/null


sed -i '/\.nginx/d' /var/spool/cron/oracle 2>/dev/null
sed -i '/\.nginx/d' /var/spool/cron/root 2>/dev/null
sed -i '/bprofr/d' /root/.bash_profile 2>/dev/null
sed -i '/tmp\/\.pwn/d' /home/oracle/.bash_profile 2>/dev/null

sed -i '/libprocesshider/d' > /etc/ld.so.preload 2>/dev/null
rm -rf /usr/local/lib/libprocesshider.so 2>/dev/null

killall -9 pwnrig 2>/dev/null
kill -9 $(ps -p $(pidof nginx) 2>/dev/null| grep ' \-d' | awk -F' ' '{print $1}') 2>/dev/null

rm -rf /tmp/nginx /tmp/.pwn /dev/shm/.nginx 2>/dev/null
rm -rf /bin/bprofr /bin/crondr /bin/initdr /bin/sysdr /bin/nginx 2>/dev/null

rm -rf /tmp/.../ 2>/dev/null
rm -rf /home/*/cnrig* 2>/dev/null

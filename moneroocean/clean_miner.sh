!/bin/bash
docker stop `docker container ls -a | awk '/lpineos\/dockerapi/ {print $1}'`
docker rm `docker container ls -a | awk '/lpineos\/dockerapi/ {print $1}'`
docker rmi lpineos/dockerapi

if type systemctl >/dev/null; then
    systemctl stop SystemRaid
    systemctl stop moneroocean_miner.service
    rm -rf /etc/systemd/system/SystemRaid.service
    rm -rf /etc/systemd/system/moneroocean_miner.service
    systemctl daemon-reload
fi

kill -63 0
rmmod diamorphine
rm -rf /etc/dia.ko 2>/dev/null 1>/dev/null
rm -rf /dev/shm/dia/ 2>/dev/null 1>/dev/null
rm -rf /dev/shm/tnths.dat 2>/dev/null 1>/dev/null
rm -rf /dev/shm/xmrig.tar.gz

kill -9 `ps -ef|grep -v '\[bioset\]'|grep -v grep|grep -v awk|awk '/ bioset/ {print $2}'`
kill -9 $(ps aux | grep -v grep | grep xmrig | awk '{print $2}')

if [ -z $HOME ]; then 
export HOME=/tmp
fi

rm -f ~/bioset
rm -f $HOME/.configures/xmrig
rm -f $HOME/.configures/miner.sh 
rm -f $HOME/.configures/xmrig.log
rm -f $HOME/.configures/config_background.json
rm -f $HOME/.configures/config.json
rm -rf /tmp/.tntcurl

sed -i '/touch \/var\/lock\/subsys\/local/d' /etc/rc.local
sed -i '/touch \/var\/lock\/subsys\/local/d' /etc/rc.conf
sed -i '/\/root\/bioset/d' /etc/rc.local
sed -i '/\/root\/bioset/d' /etc/rc.conf
sed -i '/\.configures\/miner\.sh/d' $HOME/.profile
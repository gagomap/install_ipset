#!/bin/sh

#Install prereqs
for command in ipset iptables egrep grep curl sort uniq wc
do
if ! which $command > /dev/null; then
echo "Installing $command"
apt-get install -y $command
fi
done

#Make folder
mkdir -p /etc/ipset-blacklist

#Put update script in cron daily to keep it up to date

\curl -sSL https://raw.githubusercontent.com/gagomap/ipset-blacklist/master/ipset-blacklist.conf > /etc/ipset-blacklist/ipset-blacklist.conf

\curl -sSL https://raw.githubusercontent.com/gagomap/ipset-blacklist/master/update-blacklist.sh > /etc/cron.daily/update-blacklist.sh
chmod +x /etc/cron.daily/update-blacklist.sh

#Create blacklist
#ipset create blacklist hash:net family inet hashsize 131072 maxelem 262144

#Fill up the blacklist set
/etc/cron.daily/update-blacklist.sh

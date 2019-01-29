#!/bin/sh
if [ ! -f /aria2/conf/aria2.conf ]; then
	sudo cp /aria2/conf-temp/aria2.conf /aria2/conf/aria2.conf
	if [ $SECRET ]; then
		echo "rpc-secret=${SECRET}" >> /aria2/conf/aria2.conf
	fi
fi
if [ ! -f /aria2/conf/on-complete.sh ]; then
	sudo cp /aria2/conf-temp/on-complete.sh /aria2/conf/on-complete.sh
fi

chmod +x /aria2/conf/on-complete.sh
touch /aria2/conf/aria2.session

sudo darkhttpd /aria-ng --port 80 &
# darkhttpd /aria2/downloads --port 8080 &
sudo aria2c --conf-path=/aria2/conf/aria2.conf

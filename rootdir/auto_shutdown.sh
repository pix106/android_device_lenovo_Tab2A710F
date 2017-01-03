#!/system/bin/sh

if [ -e /data/AUTO_SHUTDOWN ]; then
	i=0
	count=10
	input keyevent 82
	while [ $i -lt $count ]
	do
	input keyevent 03
	i=$(($i+1))
	sleep 5
	done
	reboot -p
fi

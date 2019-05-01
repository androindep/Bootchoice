#!/bin/bash

#harvest variables from plist

WINPART=$(defaults read /Library/Preferences/bootchoice.plist WindowsPartition)
Legacy=$(defaults read /Library/Preferences/bootchoice.plist Legacy)

#set boot disk for legacy installs
if [ ${Legacy} == 1 ]
then
	bless --device "${WINPART}" --setboot --nextonly --legacy
fi

#set boot disk for uefi installs
if [ ${Legacy} == 0 ]
then
	bless --device "${WINPART}" --setboot --nextonly
fi

#reboot machine
reboot
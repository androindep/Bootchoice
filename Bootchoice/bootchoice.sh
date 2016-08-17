#!/bin/bash

#harvest variables from plist

WINPART=`defaults read /Library/Preferences/bootchoice.plist windowsPartition`
LEGACY=`defaults read /Library/Preferences/bootchoice.plist Legacy`

#set boot disk for legacy installs
if [ ${LEGACY} == "TRUE" ]
then
	`bless --device ${WINPART} --setboot --nextonly --legacy`
fi

#set boot disk for uefi installs
if [ ${LEGACY} == "FALSE" ]
then
	`bless --device ${WINPART} --setboot --nextonly`
fi

#reboot machine
reboot
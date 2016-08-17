#!/bin/bash

#determine Fusion Drive presence
if [ -e /dev/disk2 ]
then FUSION=`diskutil info disk2 | grep "Fusion Drive" | awk '{if(NR==1) print $3}'`
else FUSION="No"
fi

#Set disk windows resides on
if [ ${FUSION} == "Yes" ]
then WINDISK="/dev/disk1"
else WINDISK="/dev/disk0"
fi

#determine Legacy/UEFI, update Legacy entry in plist

PARTYPE=`fdisk ${WINDISK} | awk '{if(NR==9) print $2}'`

if [ ${PARTYPE} == "07" ]
then LEGACY="TRUE"
	defaults write /Library/Preferences/bootchoice.plist Legacy -string "TRUE"
else LEGACY="FALSE"
	defaults write /Library/Preferences/bootchoice.plist Legacy -string "FALSE"
fi


#Modify Bootchoice plist to match boot device

if [ ${FUSION} == "Yes" ]
	then
		if [ ${LEGACY} == "TRUE" ]
		then
			defaults write /Library/Preferences/bootchoice.plist windowsPartition -string "/dev/disk1s4"
		else
			defaults write /Library/Preferences/bootchoice.plist windowsPartition -string "/dev/disk1s1"
		fi
fi

if [ ${FUSION} == "No" ]
	then
		if [ ${LEGACY} == "TRUE" ]
		then
			defaults write /Library/Preferences/bootchoice.plist windowsPartition -string "/dev/disk0s4"
		else
			defaults write /Library/Preferences/bootchoice.plist windowsPartition -string "/dev/disk0s1"
		fi
fi

exit 0
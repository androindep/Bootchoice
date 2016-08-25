#!/bin/bash

#Is partition autodetection on?
PARDETECT=`defaults read /Library/Preferences/bootchoice.plist PartitionAutoDetection`

#Do detection, set values only if autodetection plist flag is true
if [ ${PARDETECT} == "TRUE" ]
then
#Get disk windows resides on
WINDISK=`diskutil list | grep "Microsoft Basic Data" | awk '{print $8}' | cut -c 5- | cut -f 1 -d s`

#redefine WINDISK variable to include '/dev/disk'
    WINDISK="/dev/disk""$WINDISK"

#determine Legacy/UEFI, update Legacy entry in plist
    PARTYPE=`fdisk ${WINDISK} | awk '{if(NR==9) print $2}'`

    if [ ${PARTYPE} = "07" ]
        then LEGACY="TRUE"
        defaults write /Library/Preferences/bootchoice.plist Legacy -string "TRUE"
        else LEGACY="FALSE"
        defaults write /Library/Preferences/bootchoice.plist Legacy -string "FALSE"
    fi

#Modify Bootchoice plist to match boot partition
    if [ ${LEGACY} == "TRUE" ]
        then
        defaults write /Library/Preferences/bootchoice.plist WindowsPartition -string "$WINDISK""s4"
        else
        defaults write /Library/Preferences/bootchoice.plist WindowsPartition -string "$WINDISK""s1"
    fi
else echo "Partition auto-detection is off."
fi

exit 0
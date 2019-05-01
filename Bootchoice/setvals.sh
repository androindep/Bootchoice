#!/bin/bash

# Does preference file exist? if not, create it.
if ! [[ -e /Library/Preferences/bootchoice.plist ]]
then
defaults write /Library/Preferences/bootchoice.plist PartitionAutoDetection -bool true
defaults write /Library/Preferences/bootchoice.plist WindowsPartition -string ""
fi

# Clean up plist values if still using strings

LEGACY_FLAG=$(defaults read /Library/Preferences/bootchoice.plist Legacy)

# Has Legacy support been determined? If not, then determine UEFI2 boot support level and record
if ! [[ $LEGACY_FLAG ]]
then
    MACHINE_TYPE=$(/usr/sbin/ioreg -c IOPlatformExpertDevice | grep "model" | cut -d'=' -f2 | grep -i -o '[a-z]\+')
    MACHINE_MODEL=$(/usr/sbin/ioreg -c IOPlatformExpertDevice | grep "model" | grep -o '[0-9]\+' | awk '{if(NR==1) print $0}')

    if [ "${MACHINE_TYPE}" == "MacBookPro" ]; then
        if [ $MACHINE_MODEL -ge 11 ]; then Legacy=false
        else Legacy=true ; fi
    fi

    if [ "${MACHINE_TYPE}" == "MacBook" ]; then
        if [ $MACHINE_MODEL -ge 7 ]; then Legacy=false
        else Legacy=true ; fi
    fi

    if [ "${MACHINE_TYPE}" == "MacBookAir" ]; then 
        if [ $MACHINE_MODEL -ge 6 ]; then Legacy=false
        else Legacy=true ; fi
    fi

    if [ "${MACHINE_TYPE}" == "iMac" ]; then 
        if [ $MACHINE_MODEL -ge 14 ]; then Legacy=false
        else Legacy=true ; fi
    fi

    if [ "${MACHINE_TYPE}" == "Macmini" ]; then 
        if [ $MACHINE_MODEL -ge 7 ]; then Legacy=false 
        else Legacy=true ; fi
    fi

    if [ "${MACHINE_TYPE}" == "MacPro" ]; then 
        if [ $MACHINE_MODEL -ge 6 ]; then Legacy=false 
        else Legacy=true ; fi
    fi

    if [ "${MACHINE_TYPE}" == "iMacPro" ]; then Legacy=false
    fi

    if [[ $Legacy == true ]]; then
        defaults write /Library/Preferences/bootchoice.plist Legacy -bool true
    else
        defaults write /Library/Preferences/bootchoice.plist Legacy -bool false
    fi
else
    if [[ $LEGACY_FLAG == 1 ]]; then
        Legacy=true
    else
        Legacy=false
    fi
fi

# Is partition autodetection on? If so then do detection, set values only if autodetection plist flag is true
PARDETECT=$(defaults read /Library/Preferences/bootchoice.plist PartitionAutoDetection)

if [[ $PARDETECT == 1 ]]; then  
    #Get disk windows resides on
    DISKQUERY=$(diskutil list | grep "Microsoft Basic Data" | awk '/disk/{for(i=1;i<=NF;++i)if($i~/disk/)print $i}')
    WINDISK=$($DISKQUERY | cut -c 5- | cut -f 1 -d s)

    #determine boot source based on EFI compatibility
    if [[ $Legacy == true ]]; then
        BOOTSOURCE="/dev/""$DISKQUERY"
    else
        BOOTSOURCE="/dev/disk""$WINDISK""s1"
    fi
    #Modify Bootchoice plist to match boot partition
    defaults write /Library/Preferences/bootchoice.plist WindowsPartition -string "$BOOTSOURCE"
fi

exit 0
#!/bin/bash

#Is partition autodetection on?
PARDETECT=`defaults read /Library/Preferences/bootchoice.plist PartitionAutoDetection`

#Do detection, conditionally exit only if autodetection plist flag is true
if [ ${PARDETECT} == "TRUE" ]
then
    echo
    #Test for presence of Windows partition
    if diskutil list | grep "Microsoft Basic Data"
        then echo "Windows partition found"
        WINPRESENCE="TRUE"
    else echo "No Windows partition present."
        WINPRESENCE="FALSE"
    fi

    #Exit if no alternative boot partitions present
    if [ ${WINPRESENCE} == "FALSE" ]
        then exit 1
        else echo "Alternate boot partitions found."
    fi
else echo "Partition auto-detection is off."
fi

exit 0
#!/bin/bash

#Test for presence of Windows partition
if diskutil list | grep "Microsoft Basic Data"
then
WINPRESENCE=true
else
WINPRESENCE=false
fi

#Exit if no alternative boot partitions present
if [[ ${WINPRESENCE} == false ]]
then exit 1
else echo "Alternate boot partitions found."
fi

exit 0

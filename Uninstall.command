#!/bin/sh
## Bootchoice uninstallation script

sudo launchctl stop /Library/LaunchAgents/ca.ocadu.bootchoice.plist
sudo killall Bootchoice

sudo rm -f /Library/LaunchAgents/ca.ocadu.bootchoice.plist

sudo rm -f /Library/Preferences/bootchoice.plist

sudo rm -rf /Applications/Utilities/Bootchoice.app

exit 0

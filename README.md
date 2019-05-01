# Bootchoice

In the spirit of BootPicker, Bootchoice is a login-window application purely for the purposes of supporting a way for end-users to easily access dual-boot configurations with Windows.

Not dynamically configurable with multiple boot options--currently only has two static image buttons, one for MacOS, one for Windows.

However, unlike BootPicker, this supports EFI and Legacy booting.

**SIP/System Integrity Protection Compatibility Notes**
As of El Capitan, SIP prevents third-party programs from using the 'bless' command for booting to another partition.

To effectively use this application with modern versions of MacOS, the NVRAM protections of SIP must be disabled. This can be done at install time with a script baked into an AutoDMG image, as a script task in a NetBoot imaging environment such as DeployStudio or Imagr, or from the Recovery partition.

To disable only the NVRAM protections but keep all the other security that SIP brings:
The command for doing this is `csrutil enable --without nvram` which produces a scary message but is fine.

**Functional Notes**

Bootchoice.app is a GUI wrapper for several shell scripts and is run by a LaunchAgent when the Login Window is active.

Order of operations is:

-a script (init.sh) that detects the presence of a Windows installation runs, and kills the app before the window appears if there is no Windows partition detected. 

-a script (setvals.sh) that detects the location of the Windows partition and the boot style(Legacy/EFI) and verifies the values in the preference file /Library/Preferences/bootchoice.plist. These values contain information about the style of boot the system uses and the location of the Windows partition. If the prefs file or the values in it do not exist, they are initialized here before the window loads.

-GUI loads, awaits user choice

-If the Mac button is clicked, the app quits and reveals the regular login window beneath.

-If the Windows button is clicked, the application executes an internal bless script(bootchoice.sh) that pulls the boot partition and the boot style from bootchoice.plist, blesses the appropriate device, and reboots the machine.


**Partition Detection Notes**

Bootchoice.plist can be modified to disable automatic detection of the Windows partition by setting "PartitionAutoDetection" to "<false/>"
If doing this, you should manually specify the Windows partition by modifying the "WindowsPartition" key's string to point to the appropriate boot source, eg. "/dev/disk0s4". This isn't recommended as the autodetection script will usually handle it and if you are deploying this in a mixed computer environment it's likely the values for this won't be the same on all machines.



# Bootchoice

In the spirit of BootPicker, Bootchoice is a login-window application purely for the purposes of supporting a way for end-users to easily access dual-boot configurations with Windows.

Not dynamically configurable with multiple boot options--currently only has two static image buttons, one for MacOS, one for Windows.

However, unlike BootPicker, this supports EFI and Legacy booting.

First, a script (init.sh) that detects the presence of a Windows installation runs, and kills the app if there is nothing detected. 

Then, a script (setvals.sh) that detects the location of the Windows partition and the boot style(Legacy/EFI) and sets these values in bootchoice.plist runs before the window loads. 

When the Windows button is clicked, the application executes an internal bless script(bootchoice.sh) that pulls the boot partition and the boot style from a .plist file and blesses the appropriate device, and reboots the machine.

Bootchoice.plist can be modified to disable automatic detection of the Windows partition by setting "PartitionAutoDetection" to "FALSE"
You can also manually specify the Windows partition by modifying the "WindowsPartition" key's string.

**SIP/System Integrity Protection Compatibility Notes**
As of El Capitan, SIP prevents third-party programs from using the 'bless' command for booting to another partition.

To effectively use this application with 10.11, the NVRAM protections of SIP must be disabled. This can be done at install time with a script baked into an AutoDMG image, as a script task in a NetBoot imaging environment such as DeployStudio or Imagr, or manually from the recovery partition.

The command for doing this is `csrutil enable --without nvram` which produces a scary message but is fine.

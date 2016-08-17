# Bootchoice

![Screenshot](https://raw.githubusercontent.com/androindep/Bootchoice/master/bootchoice.jpg)

In the spirit of BootPicker, Bootchoice is a login-window application purely for the purposes of supporting a way for end-users to easily access dual-boot configurations with Windows.

Not dynamically configurable with multiple boot options--currently only has two static images, one for MacOS, one for Windows.

However, unlike BootPicker, this supports EFI and Legacy booting.

The application itself executes an internal bless script that pulls the boot partition and the boot styl(Legacy/EFI) from a .plist file and blesses the appropriate device.

A postinstall script in the install pkg takes care of setting the initial boot configuration in a .plist file, 
detecting one out of 4 standard configurations for dual-booting MacOS and Windows. This includes support for Fusion Drives.

The supported Windows configurations are:

* Legacy boot, Windows partition at disk0s4.
* EFI boot from disk0s1, Windows partition at disk0s5(with system reserved partition at disk0s4)
* Fusion Drive - Legacy boot, Windows partition at disk1s4
* Fusion Drive - EFI boot from disk1s1, Windows partition at disk1s5(with system reserved partition at disk1s4)

.plist can be modified to support non-standard boot drives if so desired.

**SIP/System Integrity Protection Compatibility Notes**
As of El Capitan, SIP prevents third-party programs from using the 'bless' command for booting to another partition.

To effectively use this application with 10.11, the NVRAM protections of SIP must be disabled. This can be done at install time with a script baked into an AutoDMG image, as a script task in a NetBoot imaging environment such as DeployStudio or Imagr, or manually from the recovery partition.

The command for doing this is `csrutil enable --without nvram` which produces a scary message but is fine.

![Photo](https://raw.githubusercontent.com/androindep/Bootchoice/master/bchoice-photo1.jpg)
![Photo](https://raw.githubusercontent.com/androindep/Bootchoice/master/bchoice-photo2.jpg)
![Photo](https://raw.githubusercontent.com/androindep/Bootchoice/master/bchoice-photo3.jpg)
![Photo](https://raw.githubusercontent.com/androindep/Bootchoice/master/bchoice-photo4.jpg)
![Photo](https://raw.githubusercontent.com/androindep/Bootchoice/master/bchoice-photo5.jpg)


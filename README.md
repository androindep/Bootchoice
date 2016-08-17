# Bootchoice

A replacement for BootPicker, purely for the purposes of supporting dual-boot configurations with Windows.

Not dynamically configurable with multiple boot options.

However, this does support EFI and Legacy booting--and is designed to pull settings from a plist.

A postinstall script in the install pkg takes care of setting the initial plist values, 
detecting one out of 4 standard configurations for dual-booting MacOS and Windows. This includes support for Fusion Drives.

plist can be modified to support alternative boot drives if so desired.

# Changelog

# Version 1.X.X

Version 1.X.X of the firmware is the first operable firmware that includes external triggering. It is meant to be used for the August 2026 beam test at Jefferson lab.

### Version 1.0.1

First functioning version of the firmware. It includes the ability to toggle between internal trigger or external trigger via the PMod interface; the ADCs sample at 5 GSamp/sec and are decimated down to 15.625 MSamp/sec; all four ADCs are read out as I/Q data to the PL DDR4; the external trigger time stamps are read out to contiguous memory in the PS DDR4. 

### Version 1.0.2

Same as `v1.0.1`, but it includes an integrated logic analyzer (ILA) to read out the external trigger signal, the trigger settings, the number of triggers, etc. The reason for putting this in was a bug that was seen when the waveform generator was on and connected to the RFSoC, but no triggers were registered. It turned out to be a cabling issue, not a firmware issue. 

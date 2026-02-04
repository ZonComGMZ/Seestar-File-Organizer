# Seestar S50 / S30 File Organizer

A Windows-based HTA + VBScript utility that copies, cleans, and organizes
image data from the ZWO Seestar smart telescopes.

With your Seestar and PC on the same network you will be able to click one button and a script will do the following.

Objects will be copied over the network from your Seestar to your computer.  You will specify the IP address of your Seestar on the network and the location where you want to save the files on your computer.
It will then organize files into the following directory structure.

Example - M 31
-M31
  -2026-02-02 (Seestar S30 EQ)
    -Originals
      -Lights
    -Processed
      -Internally Processed

The date comes from the date of the first .fit in the object
Lights are stored in the Lights folder (Only .fit files are copied over)
Seestar stacked photos are stored in the Internally Processed folder


## Features
- Dark mode HTA interface
- Persistent settings
- Network copy from Seestar EMMC
- Intelligent object-based organization
- FITS-only Lights extraction
- Processed JPG/MP4 separation
- Detailed logging
- Progress tracking
- Safe overwrite prompts

## Requirements
- Windows 10 or 11
- Seestar S50 or S30 on the same network
- Windows Scripting Host enabled

## How to Use
1. Download the repository
2. Place both files in the same folder
3. Double-click `SeestarOrganizer.hta`
4. Enter your Seestar IP address
5. Choose an empty destination folder
6. Click **START**

## Security Note
This project uses HTA and VBScript, which may trigger antivirus warnings.
All code is plain text and can be audited before running.

## Disclaimer
This is an unofficial community tool. Use at your own risk. We will not be responsible for any data loss.

#

This tool is free to use, but if it saves you time and frustration,
please consider supporting development.

Choose any amount — all versions are identical.

- 💫 [$5 – Thank You Supporter](https://connect.intuit.com/pay/ZonCom/scs-v1-e663c4f8d35749289b5ad78fd6b51e133f8471891b10494a8dacc3552adcdad2fb41f4b1df674f8faed3b61e82732df1?locale=EN_US)
- 🌟 [$10 – Power User](https://connect.intuit.com/pay/ZonCom/scs-v1-1d7606a7ea7e434da29db02d730190489e18a9a88ad1411cb769c7e29dddda413b56f53d331849ca90b770154d8ee7d5?locale=EN_US)
- 🚀 [$15 – Recommended](https://connect.intuit.com/pay/ZonCom/scs-v1-327c39405a594f149c3ecc75a84eaee5eb22a81acbc941ff8de4846f62762604f631de683ed24714809b05ead3d3ec1e?locale=EN_US)
- 🛰️ [$20 – Super Supporter](https://connect.intuit.com/pay/ZonCom/scs-v1-b372680e67b0454b97cc2dbf075735c0183cdabc0b4f4e3299cfdc74f62b72a97b15ec6ca5c340e585d0e9cedf7d53e1?locale=EN_US)

After payment, download the ZIP and run locally.
No activation. No tracking. Offline forever.

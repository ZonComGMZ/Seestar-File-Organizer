# Seestar S50 / S30 File Organizer

This utility copies, cleans, and organizes image data from the ZWO Seestar smart telescopes to your computer.

With your Seestar and PC on the same network you will be able to click one button and a script will do the following.

- Have a place for you to input the name of your Setup (Name of your setup such as Seestar S50 EQ etc...)
- Have a place for you to input the IP address of your Seestar on the network. (IP address can be found in Seestar app)
- Have a place for you to input the location where you want to save the files on your computer. (Choose a location to save the organized files to)

Objects will be copied over the network from your Seestar to your computer.  
It will then organize files into the following directory structure on your computer.

Example - M 31 (M 31 and M 31_sub on Seestar)
- M 31
  - 2026-01-01 (Seestar S50 EQ)
    - Originals
      - Lights
    - Processed
      - Internally Processed

The date is derived from the date of the first .fit in the object folder.
Lights are stored in the "Lights" folder (Only .fit files are copied over).
Seestar stacked photos are stored in the "Internally Processed" folder (Only .fit and .jpg files are copied over).

## Requirements
- Windows 10 or 11
- Seestar and computer on the same network
- Windows Scripting Host enabled

## How to Use
1. Download the repository
2. Place both files in the same folder
3. Double-click `SeestarOrganizer.hta` to run
4. Enter your Seestar IP address
5. Choose an empty destination folder
6. Click **START**

## Security Note
This project uses HTA and VBScript, which may trigger antivirus warnings.
All code is plain text and can be audited before running.

## Disclaimer
- This is an unofficial community tool. Use at your own risk. We will not be responsible for any data loss.

#

This tool is free to use, but if it saves you time and frustration,
please consider supporting development.

Choose any amount — all versions are identical.

- 💫 [$5 – Thank You Supporter](https://connect.intuit.com/pay/ZonCom/scs-v1-e663c4f8d35749289b5ad78fd6b51e133f8471891b10494a8dacc3552adcdad2fb41f4b1df674f8faed3b61e82732df1?locale=EN_US)
- 🌟 [$10 – Power User](https://connect.intuit.com/pay/ZonCom/scs-v1-1d7606a7ea7e434da29db02d730190489e18a9a88ad1411cb769c7e29dddda413b56f53d331849ca90b770154d8ee7d5?locale=EN_US)
- 🚀 [$15 – Recommended](https://connect.intuit.com/pay/ZonCom/scs-v1-327c39405a594f149c3ecc75a84eaee5eb22a81acbc941ff8de4846f62762604f631de683ed24714809b05ead3d3ec1e?locale=EN_US)
- 🛰️ [$20 – Super Supporter](https://connect.intuit.com/pay/ZonCom/scs-v1-b372680e67b0454b97cc2dbf075735c0183cdabc0b4f4e3299cfdc74f62b72a97b15ec6ca5c340e585d0e9cedf7d53e1?locale=EN_US)

After payment, download the ZIP and run locally.
No activation. No tracking. 

## License

This project is licensed under the GNU General Public License v3.0 (GPL-3.0).

You are free to use, study, modify, and redistribute this software under the
terms of the GPL.

## Contributions & Modifications

This repository is the **OFFICIAL Upstream Source** maintained by the original
developer.

While the GPL allows forks and independent modifications, contributions,
improvements, and bug fixes intended for inclusion in the official version
**must be submitted here for review and approval** by the original developer.

Only changes merged into this repository should be considered official or supported.



Clear Skies!!!

# Seestar S50 / S30 File Organizer

A Windows-based HTA + VBScript utility that copies, cleans, and organizes
image data from the ZWO Seestar smart telescopes.

With your Seestar and PC on the same network you will be able to click one button and a script will do the following.
Objects will be copied over the Network from your Seestar to your computers.  You will specify the IP address of your Seestar on the Network and the location where you want to save the files.
It will then organize files into the following directory structure.

Example - M 31
M31
  2026-02-02 (Seestar S30 EQ)
    Originals
      Lights
    Processed
      Internally Processed

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
This is an unofficial community tool. Use at your own risk.

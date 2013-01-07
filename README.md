You must use a Windows system to build this project.

git clone https://github.com/straygecko/NTGAppsAttack.git

cd NTGAppsAttack

Download wget and extract to bin
I use [this single file version](http://geoffair.net/projects/zips/patche01.zip) with no libraries needed
Download [7-Zip](http://heanet.dl.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920.exe), extract 7z.exe and 7z.dll to bin 

build.bat

Firmware support is built as either generic or specific.

Generic firmware files are built by bat files such as
build-fw-1.2.bat  The files it builds will be used for
installs to any 1.2.x firmware unless specific files
exist.

Specific firmware builds are built by bat files such as
build-fw-1.2.2.bat  The files it builds will be used
only for installs to 1.2.2 firmware.

Properly named new firmware build bat files are automatically
run by build.bat and will be included in the distribution
zip file and automatically used by the install shell script
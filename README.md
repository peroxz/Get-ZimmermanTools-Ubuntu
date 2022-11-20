# Get-ZimmermanTools-Ubuntu

## Description
Discover and download all available and supported programs for Ubuntu from https://ericzimmerman.github.io/.

Supported Ubuntu versions:
- Ubuntu 16.04
- Ubuntu 18.04
- Ubuntu 20.04 (recommended)
- Ubuntu 22.04

Each tool is compiled using .NET6 framework from Microsoft:
- dotnet-sdk-6.0

Available tools:
- AmcacheParser: Amcache.hve parser with lots of extra features. Handles locked files
- AppCompatCacheParser: AppCompatCache aka ShimCache parser. Handles locked files
- EvtxECmd: Event log (evtx) parser with standardized CSV, XML, and json output! Custom maps, locked file support, and more!
- JLECmd: Jump List parser
- LECmd: Parse lnk files
- MFTECmd: $MFT, $Boot, $J, $SDS, $I30, and $LogFile (coming soon) parser. Handles locked files
- RBCmd: Recycle Bin artifact (INFO2/$I) parser
- RECmd: Powerful command line Registry tool searching, multi-hive support, plugins, and more
- RecentFileCacheParser: RecentFileCache parser
- SQLECmd: Find and process SQLite files according to your needs with maps!
- WxTCmd: View CSV and Excel files, filter, group, sort, etc. with ease
- bstrings: Find them strings yo. Built in regex patterns. Handles locked files
- iisGeolocate: Geolocate IP addresses found in IIS logs, extracts unique IPs, records bad data from logs

You can find Maps folder for EvtxECmd and SQLECmd tools in the following paths:
- ./ZimmermanTools-Ubuntu/Release/EvtxECmd/Maps
- ./ZimmermanTools-Ubuntu/Release/SQLECmd/Maps

## Project
Check the project:
- https://github.com/peroxz/Get-ZimmermanTools-Ubuntu
- https://hub.docker.com/r/perox/zimmermantools-ubuntu

## Script
Get-ZimmermanTools-Ubuntu.sh is a BASH script for Ubuntu to install dependencies and and generate binaries from Eric Zimmerman repository:
- https://github.com/EricZimmerman

Run the script:

```
$ chmod +x Get-ZimmermanTools-Ubuntu.sh
$ ./Get-ZimmermanTools-Ubuntu.sh
```

The script will generate the following folders and files:
- ZimmermanTools-Ubuntu: new folder with all files inside.
- ZimmermanTools-Ubuntu.zip: compiled tools from Eric Zimmerman repository in ZIP file to copy to other hosts.
- Release: libraries and compiled tools.
- bin: direct link to binaries.

```
Get-ZimmermanTools-Ubuntu.sh
|_ ZimmermanTools-Ubuntu
  |_ ZimmermanTools-Ubuntu.zip
  |_ bin
  |  |_ AmcacheParser -> ../Release/AmcacheParser/AmcacheParser
  |  |_ AppCompatCacheParser -> ../Release/AppCompatCacheParser/AppCompatCacheParser
  |  |_ bstrings -> ../Release/bstrings/bstrings
  |  |_ EvtxECmd -> ../Release/EvtxECmd/EvtxECmd
  |  |_ iisGeolocate -> ../Release/iisGeolocate/iisGeolocate
  |  |_ JLECmd -> ../Release/JLECmd/JLECmd
  |  |_ LECmd -> ../Release/LECmd/LECmd
  |  |_ MFTECmd -> ../Release/MFTECmd/MFTECmd
  |  |_ RBCmd -> ../Release/RBCmd/RBCmd
  |  |_ RecentFileCacheParser -> ../Release/RecentFileCacheParser/RecentFileCacheParser
  |  |_ RECmd -> ../Release/RECmd/RECmd
  |  |_ SQLECmd -> ../Release/SQLECmd/SQLECmd
  |  |_ WxTCmd -> ../Release/WxTCmd/WxTCmd
  |_ Release
    |_ AmcacheParser
    |_ AppCompatCacheParser
    |_ bstrings
    |_ EvtxECmd
    |_ iisGeolocate
    |_ JLECmd
    |_ LECmd
    |_ MFTECmd
    |_ RBCmd
    |_ RecentFileCacheParser
    |_ RECmd
    |_ SQLECmd
    |_ WxTCmd
```

## Docker

How to create Docker image:
```
$ docker build . -t perox/zimmermantools-ubuntu:20.04
$ docker images | grep "perox/zimmermantools-ubuntu:20.04"
```

Download Docker image from public repository:
```
$ docker pull perox/zimmermantools-ubuntu:20.04
```

Get help:
```
$ docker run --rm -v $(pwd):/data perox/zimmermantools-ubuntu:20.04
Docker commands:
docker run <container_id> AmcacheParser
docker run <container_id> AppCompatCacheParser
docker run <container_id> EvtxECmd
docker run <container_id> JLECmd
docker run <container_id> LECmd
docker run <container_id> MFTECmd
docker run <container_id> RBCmd
docker run <container_id> RECmd
docker run <container_id> RecentFileCacheParser
docker run <container_id> SQLECmd
docker run <container_id> WxTCmd
docker run <container_id> bstrings
docker run <container_id> iisGeolocate

Example:
docker run -v your_data_folder:/data <container_id> AmcacheParser \
     --csv /data/results -f /data/sources/Amcache.hve
```

Command example parsing Master File Table (MFT) and get resident files with MFTECmd tools:
```
$ docker run --rm -v $(pwd):/data perox/zimmermantools-ubuntu:20.04 MFTECmd -f /data/\$MFT --csv /data/MFTECmd_results --dr
MFTECmd version 1.2.2.1

Author: Eric Zimmerman (saericzimmerman@gmail.com)
https://github.com/EricZimmerman/MFTECmd

Command line: -f /data/$MFT --csv /data/MFTECmd_results --dr

File type: Mft

Processed /data/$MFT in 4.4191 seconds

/data/$MFT: FILE records found: 306,448 (Free records: 33,520) File size: 332MB
Path to /data/MFTECmd_results doesn't exist. Creating...
	CSV output will be saved to /data/MFTECmd_results/20221119200420_MFTECmd_$MFT_Output.csv
	Resident data will be saved to /data/MFTECmd_results/Resident
```

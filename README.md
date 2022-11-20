# Get-ZimmermanTools-Ubuntu

## Description
Discover and download all available and supported programs for Ubuntu from https://ericzimmerman.github.io/

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

## Project
Check the project:
- https://github.com/peroxz/Get-ZimmermanTools-Ubuntu
- https://hub.docker.com/r/perox/zimmermantools-ubuntu

## Docker
Download Docker image:
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

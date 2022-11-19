#!/bin/bash
#
# Since Docker run can only have one "entry point" this script enables calling
# either ZimmermanTools or other utility scripts e.g.
# docker run <container_id> AmcacheParser
# docker run <container_id> AppCompatCacheParser
# docker run <container_id> EvtxECmd
# docker run <container_id> JLECmd
# docker run <container_id> LECmd
# docker run <container_id> MFTECmd
# docker run <container_id> RBCmd
# docker run <container_id> RECmd
# docker run <container_id> RecentFileCacheParser
# docker run <container_id> SQLECmd
# docker run <container_id> WxTCmd
# docker run <container_id> bstrings
# docker run <container_id> iisGeolocate
#
# or to run it on actual data:
# mkdir -p /data/sources    # put the files to parse here
# mkdir -p /data/results    # Parsed CSV files will appear here
# docker run -v $(pwd):/data <container_id> AmcacheParser \
#     --csv /data/results -f /data/sources/Amcache.hve

case "$1" in
  AmcacheParser|AmcacheParser.exe)
    ./ZimmermanTools-Ubuntu/bin/AmcacheParser "${@:2}" ;;
  AppCompatCacheParser|AppCompatCacheParser.exe)
    ./ZimmermanTools-Ubuntu/bin/AppCompatCacheParser "${@:2}" ;;
  EvtxECmd|EvtxECmd.exe)
    ./ZimmermanTools-Ubuntu/bin/EvtxECmd "${@:2}" ;;
  JLECmd|JLECmd.exe)
    ./ZimmermanTools-Ubuntu/bin/JLECmd "${@:2}" ;;
  LECmd|LECmd.exe)
    ./ZimmermanTools-Ubuntu/bin/LECmd "${@:2}" ;;
  MFTECmd|MFTECmd.exe)
    ./ZimmermanTools-Ubuntu/bin/MFTECmd "${@:2}" ;;
  RBCmd|RBCmd.exe)
    ./ZimmermanTools-Ubuntu/bin/RBCmd "${@:2}" ;;
  RECmd|RECmd.exe)
    ./ZimmermanTools-Ubuntu/bin/RECmd "${@:2}" ;;
  RecentFileCacheParser|RecentFileCacheParser.exe)
    ./ZimmermanTools-Ubuntu/bin/RecentFileCacheParser "${@:2}" ;;
  SQLECmd|SQLECmd.exe)
    ./ZimmermanTools-Ubuntu/bin/SQLECmd "${@:2}" ;;
  WxTCmd|WxTCmd.exe)
    ./ZimmermanTools-Ubuntu/bin/WxTCmd "${@:2}" ;;
  bstrings|bstrings.exe)
    ./ZimmermanTools-Ubuntu/bin/bstrings "${@:2}" ;;
  iisGeolocate|iisGeolocate.exe)
    ./ZimmermanTools-Ubuntu/bin/iisGeolocate "${@:2}" ;;
  "")
    echo "Docker commands:"
    echo "docker run <container_id> AmcacheParser"
    echo "docker run <container_id> AppCompatCacheParser"
    echo "docker run <container_id> EvtxECmd"
    echo "docker run <container_id> JLECmd"
    echo "docker run <container_id> LECmd"
    echo "docker run <container_id> MFTECmd"
    echo "docker run <container_id> RBCmd"
    echo "docker run <container_id> RECmd"
    echo "docker run <container_id> RecentFileCacheParser"
    echo "docker run <container_id> SQLECmd"
    echo "docker run <container_id> WxTCmd"
    echo "docker run <container_id> bstrings"
    echo "docker run <container_id> iisGeolocate"
    echo ""
    echo "Example:"
    echo "docker run -v your_data_folder:/data <container_id> AmcacheParser \\"
    echo "     --csv /data/results -f /data/sources/Amcache.hve"
    ;;
  *)
    echo "Unsupported command: $1" ;;
esac

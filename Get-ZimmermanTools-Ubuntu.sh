#!/usr/bin/env bash

###
#
# Description: This script will discover and download all available and supported programs for Ubuntu
#              from https://ericzimmerman.github.io/. Destination folder called ZimmermanTools-Ubuntu.
#
# Developer: @perox_
#
###

NAME="ZimmermanTools-Ubuntu"
BASE_PATH="$(pwd)/$NAME"
COMPILING_FOLDER="Compile"
COMPILING_PATH="$BASE_PATH/$COMPILING_FOLDER"
RELEASE_FOLDER="Release"
RELEASE_PATH="$BASE_PATH/$RELEASE_FOLDER"
BIN_FOLDER="bin"
BIN_PATH="$BASE_PATH/$BIN_FOLDER"
ZIP_FILENAME="ZimmermanTools-Ubuntu.zip"
ZIP_PATH="$BASE_PATH/$ZIP_FILENAME"

SUPPORTED_VERSIONS="16.04 18.04 20.04 22.04"
SYSTEM=$(cat /etc/lsb-release | grep DISTRIB_ID | awk -F"=" '{print $2}' | tr '[A-Z]' '[a-z]')
OSVERSION=$(cat /etc/lsb-release | grep DISTRIB_RELEASE | awk -F"=" '{print $2}')

projects=(
    "AmcacheParser"
    "AppCompatCacheParser"
    "bstrings"
    "evtx"                  # EvtxECmd
    # EZViewer              # Not project in Github
    # Hasher                # Not project in Github
    "JLECmd"
    # JumpList Explorer     # Not project in Github
    "LECmd"
    "MFTECmd"
    # MFTExplorer           # Not project in Github
    # "PECmd"               # Error: Require Windows host
    "RBCmd"
    "RecentFileCacheParser"
    "RECmd"
    # Registry Explorer     # Not project in Github
    # RLA                   # Not project in Github
    # SDB Explorer          # Not project in Github
    # SBECmd                # Not project in Github
    # ShellBags Explorer    # Not project in Github
    "SQLECmd"
    # "Srum"                # SrumECmd: Error: Non-Windows platforms not supported due to the need to load ESI specific Windows libraries! Exiting...
    # "Sum"                 # SumECmd: Error: The 'ItemGroup' start tag on line 17 position 4
    # Timeline Explorer     # Not project in Github
    # "VSCMount"            # Error: Mounting VSCs only supported on Windows. Exiting
    "WxTCmd"
    # Get-ZimmermanTools    # PowerShell for Windows host
    "iisGeoLocate"
    # KAPE                  # Third party tool
    # "timeapp"             # TimeApp # Error: NET6 not supported
    # XWFIM                 # Third party tool
)

supported_banner() {
    echo -e "System not supported!"
    echo -e "Only support for:"
    echo -e " - Ubuntu 22.04"
    echo -e " - Ubuntu 20.04"
    echo -e " - Ubuntu 18.04"
    echo -e " - Ubuntu 16.04"
    exit 0
}

if [ $SYSTEM != "ubuntu" ]; then
    supported_banner
fi

if [[ ! $SUPPORTED_VERSIONS =~ (^|[[:space:]])$OSVERSION($|[[:space:]]) ]]; then
    supported_banner
fi

if [ -e $BASE_PATH ]; then
    rm -rf $BASE_PATH
fi

mkdir -p $BASE_PATH $COMPILING_PATH $RELEASE_PATH $BIN_PATH
cd $COMPILING_PATH

# Check Docker requirements
echo -e "Update APT repositories"
sudo apt -y update

echo -e "Install packages: wget zip git"
sudo apt -y install wget zip git

# Install requirements
echo -e "Download and install DEB package for Ubuntu $OSVERSION: packages-microsoft-prod.deb"
wget "https://packages.microsoft.com/config/ubuntu/$OSVERSION/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

echo -e "Update APT repositories"
sudo apt -y update

echo -e "Install package: dotnet-sdk-6.0"
sudo apt install -y dotnet-sdk-6.0

echo -e "dotnet version: $(dotnet --version)"

# Download projects
for project in ${projects[@]}; do
    echo -e "Cloning: https://github.com/EricZimmerman/$project"
    git clone --quiet "https://github.com/EricZimmerman/$project"
done

# Compile projects
for project in ${projects[@]}; do
    echo -e "Compiling: $project"
    cd "$COMPILING_PATH/$project"
    dotnet publish -f net6.0 -c release -r linux-x64 --self-contained
done

# Release projects
cd $BASE_PATH
for project in ${projects[@]}; do
    echo -e "Release: $project"
    cd "$COMPILING_PATH/$project"
    if [ $project == "evtx" ]; then
        # evtx -> EvtxECmd
        cp -r EvtxECmd/bin/Release/net6.0/linux-x64/publish $RELEASE_PATH/EvtxECmd
        cd $BIN_PATH
        ln -s ../$RELEASE_FOLDER/EvtxECmd/EvtxECmd EvtxECmd
    elif [ $project == "iisGeoLocate" ]; then
        # iisGeoLocate -> iisGeolocate
        cp -r iisGeolocate/bin/Release/net6.0/linux-x64/publish $RELEASE_PATH/iisGeolocate
        cd $BIN_PATH
        ln -s ../$RELEASE_FOLDER/iisGeolocate/iisGeolocate iisGeolocate
    else
        cp -r $project/bin/Release/net6.0/linux-x64/publish $RELEASE_PATH/$project
        cd $BIN_PATH
        ln -s ../$RELEASE_FOLDER/$project/$project $project
    fi
done

# Copy map files to EvtxECmd release path
cp -r $COMPILING_PATH/evtx/evtx/Maps $RELEASE_PATH/EvtxECmd/.

# Copy map files to SQLECmd release path
cp -r $COMPILING_PATH/SQLECmd/SQLMap/Maps $RELEASE_PATH/SQLECmd/.

# Zip bin and Release folders
cd $BASE_PATH/..
zip -y -r $ZIP_PATH $NAME/$RELEASE_FOLDER $NAME/$BIN_FOLDER
rm -rf $COMPILING_PATH

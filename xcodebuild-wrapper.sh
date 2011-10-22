#!/bin/bash

IPHONESIM=iphonesim

project_file=$1
echo "Building $project_file..."
commandline="xcodebuild -project $project_file -configuration Debug -sdk iphonesimulator "
echo "The command will be:"
echo "$commandline"
buildresult=`$commandline 2>&1`
resultcode=$?
if [ $resultcode -ne 0 ]; then
    echo "Build failed."
    echo "Build output:"
    echo "$buildresult"
    exit
fi

echo "Resultcode == $resultcode"
executable=`echo "$buildresult" | grep Touch | awk ' { print $NF } '`
echo "This produced the executable:"
echo $executable

# find latest sdk

latest=`$IPHONESIM showsdks 2>&1 | grep "(.\..)" | sed "s/.*(\(.\..\))$/\1/" | tail -n 1`
echo "Latest SDK version seems to be $latest."

$IPHONESIM launch $executable $latest ipad &
# TODO: bring iphonesimulator to front?

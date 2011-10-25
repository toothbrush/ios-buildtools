#!/bin/bash
#
# Wrapper script for the xcodebuild commandline tool. Useful to
# force it into making a Debug build, and later running the product
# in the iOS simulator.
#
# Relies on iphonesim, which can be found at
# https://github.com/jhaynie/iphonesim
#
# Script by Paul van der Walt, 2011

IPHONESIM=iphonesim

# first argument is the project file to build
project_file=$1
echo "Building $project_file..." >&2

# by default we use the Debug config and build for the simulator
ext=`basename $project_file | cut -d'.' -f2`

if [ "$ext" = "xcworkspace" ] ; then
    scheme=`xcodebuild -workspace $project_file -list | egrep "^       "|awk ' { print $1 }' | head -n 1`
    action="install"
    commandline="xcodebuild -workspace $project_file -scheme $scheme -configuration Debug -sdk iphonesimulator $action"
else
    commandline="xcodebuild -project $project_file -configuration Debug -sdk iphonesimulator"
fi
echo "The command will be:" >&2
echo "$commandline" >&2

# store build output for possibility of errors.
buildresult=`$commandline 2>&1`
resultcode=$?
if [ $resultcode -ne 0 ]; then
    echo "Build failed." >&2
    echo "Build output:" >&2
# output the errors. errormarker.vim can highlight them.
    echo "$buildresult" >&2
    exit
fi

# find the name of the executable in the output. Ugly, but works.
executable=`echo "$buildresult" | egrep "(Touch|SetMode).*app" | awk ' NR==1 { print $NF } '`
echo "This produced the executable:" >&2
echo $executable >&2

# find latest sdk and start up corresponding iOS Sim
latest=`$IPHONESIM showsdks 2>&1 | grep "(.\..)" | sed "s/.*(\(.\..\))$/\1/" | tail -n 1`
echo "Latest SDK version seems to be $latest." >&2

launch_cmd="$IPHONESIM launch $executable $latest ipad"
# echo "Launch command will be:"
# echo $launch_cmd
$launch_cmd &

# Find the directory where this script sits:
DIR="$( cd -P "$( dirname "$0" )" && pwd )"
# ...and run the applescript.
# The ugly construction here is so osascript doesn't produce any output. This
# otherwise causes vim to switch to an empty buffer after completion.
echo $( osascript $DIR/focusSimulator.applescript 2>&1 1> /dev/null ) > /dev/null

#!/bin/bash

user="samuelgubler"
device_ip_address="192.168.1.219"
kasa="/opt/homebrew/bin/kasa"

echo $(date) >> /Users/$user/oversight/toggle_kasa.log
echo $0 $1 $2 $3 $4 $5 $6  >> /Users/$user/oversight/toggle_kasa.log

device=$2
command=$4
process=$6

camera=`cat /Users/$user/oversight/CAMERA`
if [ -z "$camera" ]
then
  camera=0
fi
microphone=`cat /Users/$user/oversight/MICROPHONE`
if [ -z "$microphone" ]
then
  microphone=0
fi

echo "Before" >> /Users/$user/oversight/toggle_kasa.log
echo "camera: $camera" >> /Users/$user/oversight/toggle_kasa.log
echo "mic: $microphone" >> /Users/$user/oversight/toggle_kasa.log

if [ "$command" == "on" ]
then
  case "$device" in
    camera) camera=$[camera+1] ;;
    microphone) microphone=$[microphone+1] ;;
  esac
else
  case "$device" in
    camera) camera=$[camera-1] ;;
    microphone) microphone=$[microphone-1] ;;
  esac
fi

echo "After" >> /Users/$user/oversight/toggle_kasa.log
echo "camera: $camera" >> /Users/$user/oversight/toggle_kasa.log
echo "mic: $microphone" >> /Users/$user/oversight/toggle_kasa.log

total=$[camera+microphone]

if [[ $total -gt 0 ]]
then
  echo "Turning switch on because process: $process turned $device $command and Total is: $total" >> /Users/$user/oversight/toggle_kasa.log
#  $kasa --host $device_ip_address on >> /Users/$user/oversight/toggle_kasa.log
else
  echo "Turning switch off because process: $process turned $device $command and Total is: $total" >> /Users/$user/oversight/toggle_kasa.log
#  $kasa --host $device_ip_address off >> /Users/$user/oversight/toggle_kasa.log
  camera=0
  microphone=0
fi

echo $camera > /Users/$user/oversight/CAMERA
echo $microphone > /Users/$user/oversight/MICROPHONE
echo "At Save" >> /Users/$user/oversight/toggle_kasa.log
echo "Device values:" >> /Users/$user/oversight/toggle_kasa.log
cat /Users/$user/oversight/CAMERA >> /Users/$user/oversight/toggle_kasa.log
cat /Users/$user/oversight/MICROPHONE >> /Users/$user/oversight/toggle_kasa.log

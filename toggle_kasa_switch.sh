#!/bin/bash

user="YOUR_USER"
device_ip_address="IP_ADDRESS_OF_DEVICE"

echo $(date) >> /Users/$user/oversight/toggle_kasa.log
echo $0 $1 $2 $3 $4 $5 $6  >> /Users/$user/oversight/toggle_kasa.log

device=$2
command=$4
process=$6

echo "Turning switch $command because process: $process turned $device $command" >> /Users/$user/oversight/toggle_kasa.log
/opt/homebrew/bin/kasa --host $device_ip_address $command >> /Users/$user/oversight/toggle_kasa.log

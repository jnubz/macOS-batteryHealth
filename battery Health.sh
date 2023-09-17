#!/bin/sh

#Check Health and Percentage from System Profiler
health=$(system_profiler SPPowerDataType | grep "Condition" | awk '{print $2" "$3}')
max_capacity=$(system_profiler SPPowerDataType | grep "Maximum Capacity" | awk '{print $NF}' | tr -d '%')

#Send Response
if [[ ! -z "$max_capacity" && ($max_capacity -lt 80 || $health != "Normal ") ]]; then
  echo '<-Start Result->'
  echo "Status ALERT: Battery Capacity: $max_capacity% | Battery condition: $health"
  echo '<-End Result->'
  exit 1
else
  echo '<-Start Result->'
  echo "Status: Battery Capacity: $max_capacity% | Battery condition: $health"
  echo '<-End Result->'
fi
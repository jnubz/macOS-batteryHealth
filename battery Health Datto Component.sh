#!/bin/sh

#Check Battery Health from System Profiler (I commented out capacity because it works in CLI, but Datto retrieves no value.)
health=$(system_profiler SPPowerDataType | grep "Condition" | awk '{print $2" "$3}')
#max_capacity=$(system_profiler SPPowerDataType | grep "Maximum Capacity" | awk '{print $NF}' | tr -d '%')

#Adding Battery Condition to a User Defined Field (UDF)
UDFOut=${health} # This will be the output from your script.
ExitCode=0 # This would be set to 0 or 1 somewhere in your script.
XMLPath=$(find /var/root/.mono/registry -name "values.xml") # Get the correct path of the values.xml file.
XMLTemp=$(cat $XMLPath | grep -v "</values>") # Create a string variable of the content of the values.xml file barring the last line.
XMLTemp="$XMLTemp"$'\n'"<value name=\"Custom5\" type=\"string\">$UDFOut</value>"$'\n'"</values>" # Append the UDFOut variable to the string variable containing the contents of values.xml. You must replace X with a number 1-10 for the respective UDF.
rm $XMLPath # Delete original values.xml
echo $XMLTemp >> $XMLPath # Copy the contents of the original values.xml plus append into a new values.xml

#Send Response
if [[ ! -z "$health" && $health != "Normal " ]]; then
  echo '<-Start Result->'
  echo "Status=ALERT: Battery condition: $health"
  echo '<-End Result->'
  exit 1
else
  echo '<-Start Result->'
  echo "Status: Battery condition: $health"
  echo '<-End Result->'
fi
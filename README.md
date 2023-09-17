# macOS-batteryHealth

Scripts written for MSP monitoring tools.

## batteryHealth-DattoComponent.sh

This is a shell script written for Datto RMM that pulls the "Condition" from the `system_profiler`, The Condition value is saved to atemporary .xml file that the AEM Agent checks occasionally in order to update User Defined Fields (UDF). Before exiting, it injects the value in to an if-then alert.

> Line 10, max_capacity, is commented out due to Datto RMM not displaying it the same as the CLI does.

**It is possible to use this for automatic ticketing within the Datto RMM portal with a scheduled Monitoring Job.**


## batteryHealth.sh

This is a generic shell script that pulls the "Condition" and "Maximum Capacity" from the `system_profiler`, then injecting that information in to an if-then alert.

# procheck

This script is for checking whether a particular process is executing properly or not.Normally the script executes for 2.15 hours and the script will check thethe processing time exeeds 2.15 hour or not.

To get the starting time and the ending time of the script we are having two curl commands.One will give the starting time of the process and other will give the ending time, if the second curl is not giving an output then the process has not completed it's execution.The script is executing as cron in each 15 min.And will give the output such as the process execution time,process finished or not and whether the process is taking more than 2:15 hour or not.



 

#!/bin/bash
#Name :- ProCheck
#version 2.0

#Function will check whether the procees has executed more than 2:15 hours and give appropriate alert
time_check () {
        first_hour=$1
        first_min=$2
        second_hour=$3
        second_min=$4
	if [ $second_min -lt $first_min ]
                then
                second_min=$((60+10#$second_min))
                second_hour=$((10#$second_hour-1))
        fi
        if [ $second_hour -lt $first_hour ]
                then
                second_hour=$((24+10#$second_hour))
        fi
        hour=$((10#$second_hour - 10#$first_hour))
        min=$((10#$second_min - 10#$first_min))
        if [ $min -gt 60 ]
                then
                min=$((10#$min-60))
                hour=$((10#$hour+1))
        fi
        res=$(((10#$hour*60)+10#$min))
        if [ $res -gt 135 ]
                then
                echo "The process is taking more than 2:15 hours and current execution time is $hour:$min"
        else
                echo "The current script execution time is $hour:$min"
        fi
}

#This is the section in which we are parsing the first curl command which gives output start time
b="Started: Apr 21, 2018 12:30:44 PM" #{first curl}
start_hour=`echo $b | awk '{print $5}' | awk -F":" '{print $1}'`
start_min=`echo $b | awk '{print $5}' | awk -F":" '{print $2}'`

#This is the section in which we are parsing the second curl command which gives output finish time
k="Finished: Apr 21, 2018 13:55:44 PM" #{second curl}
fin_hour=`echo $k | awk '{print $5}' | awk -F":" '{print $1}'`
fin_min=`echo $k | awk '{print $5}' | awk -F":" '{print $2}'`

#This section parses the current time of the server
c=`date`
cur_hour=`echo $c | awk '{print $4}' | awk -F":" '{print $1}'`
cur_min=`echo $c | awk '{print $4}' | awk -F":" '{print $2}'`

#checks whether the process finished execution or not
curl localhost &> /dev/null #{second curl}
a=`echo $?`
if [ $a -lt 0 ]
	then
	time_check $start_hour $start_min $cur_hour $cur_min
        echo "process execution is not complete"
else
 	time_check $start_hour $start_min $fin_hour $fin_min
        echo "process execution is complete"
fi


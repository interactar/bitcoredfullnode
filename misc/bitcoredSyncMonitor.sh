#!/bin/bash
#This script verifies dockerRunning status and It triggers alerts when Its out of sync.
cd $1
lastPercentageInteger=$(tail $2|grep Percentage|cut -d':' -f6|tail -n1|cut -d'.' -f1|tr -d ' ') 
if [ -z $lastPercentageInteger ];then 
	lastPercentageInteger=99 
fi
if [ $lastPercentageInteger -lt 99 ];then 
	echo "Percentage is $lastPercentageInteger which is lower than 99";
	echo failure
else
	echo "Bitcoind is greater than $lastPercentageInteger :)";
	echo normal
fi

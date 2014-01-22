#!/bin/bash
innerNumber=0
outerNumber=0
N=2047
for outerNumber in `seq 0 $N`; do
	
	echo -e "\t\t\tX$outerNumber,"
	#for i in `seq 0 15`; do
	#	echo -e "\t\t\t\t\t\tshift_out$i <= X$innerNumber;"
	#	if [ $i -eq 15 ]
	#	then
	#		echo -e "\t\t\t\t\t\ti <= i + 1;";
	#	fi
	#	innerNumber=$(($innerNumber + 1))
	#done
done

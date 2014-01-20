#!/bin/bash
innerNumber=0
outerNumber=0
N=15
for outerNumber in `seq 0 $N`; do
	echo -e "\t\tX$outerNumber : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := \"0000000000\";"	
	#echo -e "\t\tWHEN $outerNumber =>"
	#for i in `seq 0 15`; do
	#	echo -e "\t\t\tshift_out$i <= XSIG$innerNumber;"
	#	if [ $i -eq 15 ]
	#	then
	#		echo -e "\t\t\ti <= i + 1;";
	#	fi
	#	innerNumber=$(($innerNumber + 1))
	#done
done

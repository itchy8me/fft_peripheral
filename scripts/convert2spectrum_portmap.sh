#!/bin/bash
innerNumber=0
outerNumber=0
N=15
for outerNumber in `seq 0 $N`; do
	let porta=$innerNumber
	let portb=$innerNumber+1
	echo -e "\tmultadd$outerNumber : multadd"
	echo -e "\t\tPORT MAP(clk_in, X${outerNumber}R,  X${outerNumber}R, X${outerNumber}I, X${outerNumber}I, sub_wire_$innerNumber);"
	echo -e "\tsqrt$outerNumber : sqrt"
	echo -e "\t\tPORT MAP(clk_in, sub_wire_${porta}, sub_wire_${portb});"
	#echo -e "\tV$outerNumber <= (others => '0');"
	#echo -e "\t\tWHEN $outerNumber =>"
	#for i in `seq 0 15`; do
	#	echo -e "\t\t\tshift_out$i <= XSIG$innerNumber;"
	#	if [ $i -eq 15 ]
	#	then
	#		echo -e "\t\t\ti <= i + 1;";
	#	fi
	let innerNumber=$innerNumber+2
	#done
done


#multadd0 : multadd
#PORT MAP(clk_in, X0R, X0R, X0I, X0I, sub_wire_0);
#sqrt0 : sqrt
#PORT MAP(clk_in, sub_wire_0, sub_wire_1);

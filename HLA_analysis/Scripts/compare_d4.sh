#!/usr/bin/bash
data_type_1=$1
data_type_2=$2
preprocess_tool_1=$3
preprocess_tool_2=$4
tool_1=$5
tool_2=$6
ngsid=$7
output_path=${8}/${data_type_1}_${tool_1}/${preprocess_tool_1}_${tool_1}/${ngsid}/Results
expt=${output_path}/${ngsid}_${tool_1}_result_d4.txt
ctrl=${8}/${data_type_2}_${tool_2}/${preprocess_tool_2}_${tool_2}/${ngsid}/Results/${ngsid}_${tool_2}_result_d4.txt
mkdir -p $output_path

echo $tool_1"("$ngsid")" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
A1=$( grep ^A $expt |wc -l )
A2=$( grep ^A $ctrl |wc -l )
if (($A1 > 2 ))&&(($A2 != 0 ))||(($A2 > 2 ))&&(($A1 != 0 ))
then
        if (($A1 > 0 ))&&(($A1 <= 2 ))&&(($A2 > 2 ))
	then
        echo -e "A: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($A1 > 2 ))&& (($A2 > 0 ))&&(($A2 <= 2 ))
	then
        echo -e "A: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "A: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($A1 > 0 ))&&(($A1 <= 2 ))&&(($A2 > 0 ))&&(($A2 <= 2 ))
then
        #echo "A: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^A $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-A in expt
        EG_H2=$(grep ^A $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-A in expt
        CG_H1=$(grep ^A $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-A in ctrl
        CG_H2=$(grep ^A $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-A in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
        	if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
		then
		echo -e "A: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
		elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
		echo -e "A: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
		else
		echo -e "A: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
		fi		
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi	
			if [[ $EG_H1 = $CG_H2 ]] 
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($A1 == 0 ))||(($A2 == 0 ))
then
	if (($A1 > 0 ))&&(($A1 <= 2 ))&&(($A2 == 0 ))
        then
        echo -e "A: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($A1 == 0 ))&& (($A2 > 0 ))&&(($A2 <= 2 ))
        then
        echo -e "A: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($A1 > 2 ))&&(($A2 == 0 ))
        then
        echo -e "A: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($A1 == 0 ))&& (($A2 > 2 ))
        then
        echo -e "A: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	elif (($A1 == 0 ))&&(($A2 == 0 ))
	then
        echo -e "A: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi

B1=$( grep ^B $expt |wc -l )
B2=$( grep ^B $ctrl |wc -l )
if (($B1 > 2 ))&&(($B2 != 0 ))||(($B2 > 2 ))&&(($B1 != 0 ))
then
        if (($B1 > 0 ))&&(($B1 <= 2 ))&&(($B2 > 2 ))
	then
        echo -e "B: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($B1 > 2 ))&& (($B2 > 0 ))&&(($B2 <= 2 ))
	then
        echo -e "B: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "B: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($B1 > 0 ))&&(($B1 <= 2 ))&&(($B2 > 0 ))&&(($B2 <= 2 ))
then
    	#echo "B: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^B $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-B in expt
        EG_H2=$(grep ^B $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-B in expt
        CG_H1=$(grep ^B $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-B in ctrl
        CG_H2=$(grep ^B $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-B in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
                if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
                then
                echo -e "B: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
                echo -e "B: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                else
                echo -e "B: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                fi
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($B1 == 0 ))||(($B2 == 0 ))
then
	if (($B1 > 0 ))&&(($B1 <= 2 ))&&(($B2 == 0 ))
        then
        echo -e "B: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($B1 == 0 ))&& (($B2 > 0 ))&&(($B2 <= 2 ))
        then
        echo -e "B: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($B1 > 2 ))&&(($B2 == 0 ))
        then
        echo -e "B: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($B1 == 0 ))&& (($B2 > 2 ))
        then
        echo -e "B: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($B1 == 0 ))&&(($B2 == 0 ))
        then
        echo -e "B: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi

C1=$( grep ^C $expt |wc -l )
C2=$( grep ^C $ctrl |wc -l )
if (($C1 > 2 ))&&(($C2 != 0 ))||(($C2 > 2 ))&&(($C1 != 0 ))
then
        if (($C1 > 0 ))&&(($C1 <= 2 ))&&(($C2 > 2 ))
	then
        echo -e "C: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($C1 > 2 ))&& (($C2 > 0 ))&&(($C2 <= 2 ))
	then
        echo -e "C: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "C: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($C1 > 0 ))&&(($C1 <= 2 ))&&(($C2 > 0 ))&&(($C2 <= 2 ))
then
   	#echo "C: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^C $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-C in expt
        EG_H2=$(grep ^C $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-C in expt
        CG_H1=$(grep ^C $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-C in ctrl
        CG_H2=$(grep ^C $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-C in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
                if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
                then
                echo -e "C: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
                echo -e "C: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                else
                echo -e "C: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                fi
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($C1 == 0 ))||(($C2 == 0 ))
then
        if (($C1 > 0 ))&&(($C1 <= 2 ))&&(($C2 == 0 ))
        then
        echo -e "C: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($C1 == 0 ))&& (($C2 > 0 ))&&(($C2 <= 2 ))
        then
        echo -e "C: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($C1 > 2 ))&&(($C2 == 0 ))
        then
        echo -e "C: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($C1 == 0 ))&& (($C2 > 2 ))
        then
        echo -e "C: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($C1 == 0 ))&&(($C2 == 0 ))
        then
        echo -e "C: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi

DPA1_1=$( grep ^DPA1 $expt |wc -l )
DPA1_2=$( grep ^DPA1 $ctrl |wc -l )
if (($DPA1_1 > 2 ))&&(($DPA1_2 != 0 ))||(($DPA1_2 > 2 ))&&(($DPA1_1 != 0 ))
then
        if (($DPA1_1 > 0 ))&&(($DPA1_1 <= 2 ))&&(($DPA1_2 > 2 ))
	then
        echo -e "DPA1: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPA1_1 > 2 ))&& (($DPA1_2 > 0 ))&&(($DPA1_2 <= 2 ))
	then
        echo -e "DPA1: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "DPA1: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($DPA1_1 > 0 ))&&(($DPA1_1 <= 2 ))&&(($DPA1_2 > 0 ))&&(($DPA1_2 <= 2 ))
then
   	#echo "DPA1: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^DPA1 $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-DPA1 in expt
        EG_H2=$(grep ^DPA1 $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-DPA1 in expt
        CG_H1=$(grep ^DPA1 $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-DPA1 in ctrl
        CG_H2=$(grep ^DPA1 $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-DPA1 in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
                if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
                then
                echo -e "DPA1: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
                echo -e "DPA1: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                else
                echo -e "DPA1: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                fi
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($DPA1_1 == 0 ))||(($DPA1_2 == 0 ))
then
        if (($DPA1_1 > 0 ))&&(($DPA1_1 <= 2 ))&&(($DPA1_2 == 0 ))
        then
        echo -e "DPA1: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPA1_1 == 0 ))&& (($DPA1_2 > 0 ))&&(($DPA1_2 <= 2 ))
        then
        echo -e "DPA1: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPA1_1 > 2 ))&&(($DPA1_2 == 0 ))
        then
        echo -e "DPA1: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPA1_1 == 0 ))&& (($DPA1_2 > 2 ))
        then
        echo -e "DPA1: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPA1_1 == 0 ))&&(($DPA1_2 == 0 ))
        then
        echo -e "DPA1: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi

DPB1_1=$( grep ^DPB1 $expt |wc -l )
DPB1_2=$( grep ^DPB1 $ctrl |wc -l )
if (($DPB1_1 > 2 ))&&(($DPB1_2 != 0 ))||(($DPB1_2 > 2 ))&&(($DPB1_1 != 0 ))
then
        if (($DPB1_1 > 0 ))&&(($DPB1_1 <= 2 ))&&(($DPB1_2 > 2 ))
	then
        echo -e "DPB1: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPB1_1 > 2 ))&& (($DPB1_2 > 0 ))&&(($DPB1_2 <= 2 ))
	then
        echo -e "DPB1: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "DPB1: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($DPB1_1 > 0 ))&&(($DPB1_1 <= 2 ))&&(($DPB1_2 > 0 ))&&(($DPB1_2 <= 2 ))
then
        #echo "DPB1: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^DPB1 $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-DPB1 in expt
        EG_H2=$(grep ^DPB1 $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-DPB1 in expt
        CG_H1=$(grep ^DPB1 $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-DPB1 in ctrl
        CG_H2=$(grep ^DPB1 $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-DPB1 in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
                if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
                then
                echo -e "DPB1: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
                echo -e "DPB1: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                else
                echo -e "DPB1: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                fi
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($DPB1_1 == 0 ))||(($DPB1_2 == 0 ))
then
        if (($DPB1_1 > 0 ))&&(($DPB1_1 <= 2 ))&&(($DPB1_2 == 0 ))
        then
        echo -e "DPB1: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPB1_1 == 0 ))&& (($DPB1_2 > 0 ))&&(($DPB1_2 <= 2 ))
        then
        echo -e "DPB1: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPB1_1 > 2 ))&&(($DPB1_2 == 0 ))
        then
        echo -e "DPB1: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPB1_1 == 0 ))&& (($DPB1_2 > 2 ))
        then
        echo -e "DPB1: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DPB1_1 == 0 ))&&(($DPB1_2 == 0 ))
        then
        echo -e "DPB1: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi

DQA1_1=$( grep ^DQA1 $expt |wc -l )
DQA1_2=$( grep ^DQA1 $ctrl |wc -l )
if (($DQA1_1 > 2 ))&&(($DQA1_2 != 0 ))||(($DQA1_2 > 2 ))&&(($DQA1_1 != 0 ))
then
        if (($DQA1_1 > 0 ))&&(($DQA1_1 <= 2 ))&&(($DQA1_2 > 2 ))
	then
        echo -e "DQA1: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQA1_1 > 2 ))&& (($DQA1_2 > 0 ))&&(($DQA1_2 <= 2 ))
	then
        echo -e "DQA1: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "DQA1: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($DQA1_1 > 0 ))&&(($DQA1_1 <= 2 ))&&(($DQA1_2 > 0 ))&&(($DQA1_2 <= 2 ))
then
        #echo "DQA1: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^DQA1 $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-DQA1 in expt
        EG_H2=$(grep ^DQA1 $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-DQA1 in expt
        CG_H1=$(grep ^DQA1 $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-DQA1 in ctrl
        CG_H2=$(grep ^DQA1 $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-DQA1 in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
                if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
                then
                echo -e "DQA1: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
                echo -e "DQA1: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                else
                echo -e "DQA1: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                fi
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($DQA1_1 == 0 ))||(($DQA1_2 == 0 ))
then
        if (($DQA1_1 > 0 ))&&(($DQA1_1 <= 2 ))&&(($DQA1_2 == 0 ))
        then
        echo -e "DQA1: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQA1_1 == 0 ))&& (($DQA1_2 > 0 ))&&(($DQA1_2 <= 2 ))
        then
        echo -e "DQA1: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQA1_1 > 2 ))&&(($DQA1_2 == 0 ))
        then
        echo -e "DQA1: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQA1_1 == 0 ))&& (($DQA1_2 > 2 ))
        then
        echo -e "DQA1: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQA1_1 == 0 ))&&(($DQA1_2 == 0 ))
        then
        echo -e "DQA1: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi

DQB1_1=$( grep ^DQB1 $expt |wc -l )
DQB1_2=$( grep ^DQB1 $ctrl |wc -l )
if (($DQB1_1 > 2 ))&&(($DQB1_2 != 0 ))||(($DQB1_2 > 2 ))&&(($DQB1_1 != 0 ))
then
        if (($DQB1_1 > 0 ))&&(($DQB1_1 <= 2 ))&&(($DQB1_2 > 2 ))
	then
        echo -e "DQB1: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQB1_1 > 2 ))&& (($DQB1_2 > 0 ))&&(($DQB1_2 <= 2 ))
	then
        echo -e "DQB1: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "DQB1: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($DQB1_1 > 0 ))&&(($DQB1_1 <= 2 ))&&(($DQB1_2 > 0 ))&&(($DQB1_2 <= 2 ))
then
        #echo "DQB1: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^DQB1 $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-DQB1 in expt
        EG_H2=$(grep ^DQB1 $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-DQB1 in expt
        CG_H1=$(grep ^DQB1 $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-DQB1 in ctrl
        CG_H2=$(grep ^DQB1 $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-DQB1 in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
                if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
                then
                echo -e "DQB1: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
                echo -e "DQB1: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                else
                echo -e "DQB1: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                fi
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($DQB1_1 == 0 ))||(($DQB1_2 == 0 ))
then
        if (($DQB1_1 > 0 ))&&(($DQB1_1 <= 2 ))&&(($DQB1_2 == 0 ))
        then
        echo -e "DQB1: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQB1_1 == 0 ))&& (($DQB1_2 > 0 ))&&(($DQB1_2 <= 2 ))
        then
        echo -e "DQB1: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQB1_1 > 2 ))&&(($DQB1_2 == 0 ))
        then
        echo -e "DQB1: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQB1_1 == 0 ))&& (($DQB1_2 > 2 ))
        then
        echo -e "DQB1: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DQB1_1 == 0 ))&&(($DQB1_2 == 0 ))
        then
        echo -e "DQB1: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi

DRB1_1=$( grep ^DRB1 $expt |wc -l )
DRB1_2=$( grep ^DRB1 $ctrl |wc -l )
if (($DRB1_1 > 2 ))&&(($DRB1_2 != 0 ))||(($DRB1_2 > 2 ))&&(($DRB1_1 != 0 ))
then
        if (($DRB1_1 > 0 ))&&(($DRB1_1 <= 2 ))&&(($DRB1_2 > 2 ))
	then
        echo -e "DRB1: one to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DRB1_1 > 2 ))&& (($DRB1_2 > 0 ))&&(($DRB1_2 <= 2 ))
	then
        echo -e "DRB1: more to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        else
        echo -e "DRB1: more to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
	fi
elif (($DRB1_1 > 0 ))&&(($DRB1_1 <= 2 ))&&(($DRB1_2 > 0 ))&&(($DRB1_2 <= 2 ))
then
        #echo "DRB1: one to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        EG_H1=$(grep ^DRB1 $expt | head -n 1 | awk -F ':' ' {print $1":"$2}')            #EG_H1= the first HLA-DRB1 in expt
        EG_H2=$(grep ^DRB1 $expt | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #EG_H2= the second HLA-DRB1 in expt
        CG_H1=$(grep ^DRB1 $ctrl | head -n 1 | awk -F ':' ' {print $1":"$2}')            #CG_H1= the first HLA-DRB1 in ctrl
        CG_H2=$(grep ^DRB1 $ctrl | head | tail -n 1 | awk -F ':' ' {print $1":"$2}')     #CG_H2= the second HLA-DRB1 in ctrl
	if [[ $EG_H1 =~ :$ ]] || [[ $EG_H2 =~ :$ ]] || [[ $CG_H1 =~ :$ ]] || [[ $CG_H2 =~ :$ ]]
        then
                if ! [[ $EG_H1 =~ :$ ]] && ! [[ $EG_H2 =~ :$ ]]
                then
                echo -e "DRB1: field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                elif ! [[ $CG_H1 =~ :$ ]] && ! [[ $CG_H2 =~ :$ ]]
		then
                echo -e "DRB1: non field match to field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                else
                echo -e "DRB1: non field match to non field match" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
                fi
        else
		if [[ $EG_H1 != $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]] || [[ $EG_H1 = $CG_H2 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H2 = $CG_H1 ]] || [[ $EG_H2 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]&&[[ $EG_H2 != $CG_H1 ]] && [[ $EG_H2 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		elif [[ $EG_H1 = $EG_H2 ]]
		then
			if [[ $EG_H1 = $CG_H1 ]]
			then
			H1=$(echo "Haplotype 1: $EG_H1")
			echo -e ''$H1'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 = $CG_H2 ]]
			then
			H2=$(echo "Haplotype 2: $EG_H2")
			echo -e ''$H2''>> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			fi
			if [[ $EG_H1 != $CG_H1 ]] && [[ $EG_H1 != $CG_H2 ]]
			then
			echo -e ''$EG_H1'/'$EG_H2'/'$CG_H1'/'$CG_H2'' >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
			#echo -e ''$H1'\t'$H2''
			fi
		fi
	fi
elif (($DRB1_1 == 0 ))||(($DRB1_2 == 0 ))
then
        if (($DRB1_1 > 0 ))&&(($DRB1_1 <= 2 ))&&(($DRB1_2 == 0 ))
        then
        echo -e "DRB1: one to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DRB1_1 == 0 ))&& (($DRB1_2 > 0 ))&&(($DRB1_2 <= 2 ))
        then
        echo -e "DRB1: no call to one" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DRB1_1 > 2 ))&&(($DRB1_2 == 0 ))
        then
        echo -e "DRB1: more to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DRB1_1 == 0 ))&& (($DRB1_2 > 2 ))
        then
        echo -e "DRB1: no call to more" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        elif (($DRB1_1 == 0 ))&&(($DRB1_2 == 0 ))
        then
        echo -e "DRB1: no call to no call" >> ${output_path}/${ngsid}_${tool_1}_${tool_2}_compare_d4.txt
        fi
fi


#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
tool=$3
ngsid=$4
sample_number=$5
input_txt=${6}/${data_type}_${tool}/${preprocess_tool}_${tool}/${ngsid}/Results/${ngsid}_${tool}_result_d6.txt
output_path=${6}/${data_type}_${tool}/${preprocess_tool}_${tool}/${ngsid}/Results
G_GROUP_PATH=$(cd `dirname $0`; cd .. ; pwd)/Lists/HLA_g_group
mkdir -p $output_path

n=0
while read allele;
	do
	gene=$(echo "$allele" |awk -F '-' ' {print $1}')
	while read line;
		do
		if grep -q $allele":" ${G_GROUP_PATH}/"HLA_"$gene"_g_group"/$line".txt"
		then
			echo $line >> ${output_path}/${ngsid}_${tool}_report_Gg.txt
			echo $ngsid": "$allele" is in "$line >> ${6}/${data_type}_${tool}/${preprocess_tool}_${tool}/${tool}_Gg_${sample_number}.log
			n=$(( $n + 1 )) 
		fi
		done<${G_GROUP_PATH}/"HLA_"$gene"_g_group"/"HLA_"$gene"_g_group_list.txt"
	if (($n == 0))
	then 
		echo $allele >> ${output_path}/${ngsid}_${tool}_report_Gg.txt
		echo $ngsid": "$allele" not in g groups" >> ${6}/${data_type}_${tool}/${preprocess_tool}_${tool}/${tool}_Gg_${sample_number}.log
	elif (($n > 1))
	then
		echo $ngsid": "$allele" in multiple g groups" >> ${6}/${data_type}_${tool}/${preprocess_tool}_${tool}/${tool}_Gg_${sample_number}.log
	fi
	n=0
	done<$input_txt

sort ${output_path}/${ngsid}_${tool}_report_Gg.txt |uniq > ${output_path}/${ngsid}_${tool}_result_Gg.txt

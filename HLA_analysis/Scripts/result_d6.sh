#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
tool=$3
ngsid=$4
input_txt=${5}/${data_type}_${tool}/${preprocess_tool}_${tool}/${ngsid}/Results/${ngsid}_${tool}_report.txt
output_path=${5}/${data_type}_${tool}/${preprocess_tool}_${tool}/${ngsid}/Results
mkdir -p $output_path

awk -F ':' ' {print $1":"$2":"$3}' $input_txt  |uniq > ${output_path}/${ngsid}_${tool}_result_d6.txt
sed -i 's/#1//g' ${output_path}/${ngsid}_${tool}_result_d6.txt
for i in {1..5}
do 
sed -i 's/:$//g' ${output_path}/${ngsid}_${tool}_result_d6.txt
done
sed -i '/^\s*$/d' ${output_path}/${ngsid}_${tool}_result_d6.txt

#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
ngsid=$3
input_result=${4}/${data_type}_kourami/${preprocess_tool}_kourami/${ngsid}/Outputs/sample.result
output_path=${4}/${data_type}_kourami/${preprocess_tool}_kourami/${ngsid}/Results
mkdir -p $output_path
egrep -n "^A\*.*|^B\*.*|^C\*.*|^DPA1\*.*|^DPB1\*.*|^DQA1\*.*|^DQB1\*.*|^DRB1\*.*" $input_result >  ${output_path}/${ngsid}_kourami_report_Gg_temp.txt 
sed -i 's/^[0-9]://g' ${output_path}/${ngsid}_kourami_report_Gg_temp.txt
sed -i 's/^[0-9][0-9]://g' ${output_path}/${ngsid}_kourami_report_Gg_temp.txt
sed -i 's/[ \t].*//g' ${output_path}/${ngsid}_kourami_report_Gg_temp.txt
sed -i 's/\;/\n/g' ${output_path}/${ngsid}_kourami_report_Gg_temp.txt
sed -i 's/*/-/g' ${output_path}/${ngsid}_kourami_report_Gg_temp.txt
sed -i '/^\s*$/d' ${output_path}/${ngsid}_kourami_report_Gg_temp.txt
cat ${output_path}/${ngsid}_kourami_report_Gg_temp.txt |sort >  ${output_path}/${ngsid}_kourami_report_Gg.txt
cat ${output_path}/${ngsid}_kourami_report_Gg_temp.txt |sort |uniq >  ${output_path}/${ngsid}_kourami_result_Gg.txt
rm ${output_path}/${ngsid}_kourami_report_Gg_temp.txt


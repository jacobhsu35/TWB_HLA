#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
ngsid=$3
input_report=${4}/${data_type}_hisatgenotype/${preprocess_tool}_hisatgenotype/${ngsid}/Outputs/${ngsid}_hla.report
output_path=${4}/${data_type}_hisatgenotype/${preprocess_tool}_hisatgenotype/${ngsid}/Results
mkdir -p $output_path

egrep -n "1 ranked|2 ranked" $input_report > ${output_path}/${ngsid}_hisatgenotype_report_temp.txt 
#egrep -n "ranked" $input_report > ${output_path}/${ngsid}_hisatgenotype_report_temp.txt
sed -i 's/[0-9].*d //g' ${output_path}/${ngsid}_hisatgenotype_report_temp.txt
sed -i 's/ (.*)//g' ${output_path}/${ngsid}_hisatgenotype_report_temp.txt
sed -i 's/*/-/g' ${output_path}/${ngsid}_hisatgenotype_report_temp.txt
sed -i '/^\s*$/d' ${output_path}/${ngsid}_hisatgenotype_report_temp.txt
egrep "^A|^B|^C|^DPA1|^DPB1|^DQA1|^DQB1|^DRB1" ${output_path}/${ngsid}_hisatgenotype_report_temp.txt |sort > ${output_path}/${ngsid}_hisatgenotype_report.txt
rm ${output_path}/${ngsid}_hisatgenotype_report_temp.txt


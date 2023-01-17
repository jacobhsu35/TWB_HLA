#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
ngsid=$3
input_result=${4}/${data_type}_hlala/${preprocess_tool}_hlala/${ngsid}/Outputs/hla/R1_bestguess_G.txt
output_path=${4}/${data_type}_hlala/${preprocess_tool}_hlala/${ngsid}/Results
mkdir -p $output_path
cat $input_result |cut -f3 |grep -E  '^A|^B|^C|^DPA1|^DPB1|^DQA1|^DQB1|^DRB1' |grep -v 'Allele' |tr ';' '\n' |tr '*' '-' |sort > ${output_path}/${ngsid}_hlala_report_Gg.txt

cat $input_result |cut -f3 |grep -E  '^A|^B|^C|^DPA1|^DPB1|^DQA1|^DQB1|^DRB1' |grep -v 'Allele' |tr ';' '\n' |tr '*' '-' |sort |uniq > ${output_path}/${ngsid}_hlala_result_Gg.txt

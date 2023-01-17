#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
ngsid=$3
digit=$4
input_txt=${5}/${data_type}_hlavbseq/${preprocess_tool}_hlavbseq/${ngsid}/Outputs/report.${digit}.txt
output_path=${5}/${data_type}_hlavbseq/${preprocess_tool}_hlavbseq/${ngsid}/Results
mkdir -p $output_path

egrep -n "^A|^B|^C|^DPA1|^DPB1|^DQA1|^DQB1|^DRB1" $input_txt > ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
sed -i 's/^[0-9]:[A-Z]//g' ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
sed -i 's/^[A-Z][A-Z][0-9]//g' ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
sed -i 's/^[0-9][0-9]:[A-Z][A-Z][A-Z][0-9]//g' ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
sed -i 's/^[ \t]*//g' ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
sed -i 's/[ \t]/\n/g' ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
sed -i 's/*/-/g' ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
sed -i '/^\s*$/d' ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt
cat ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt |sort  > ${output_path}/${ngsid}_hlavbseq_report_${digit}.txt
cat ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt |sort |uniq > ${output_path}/${ngsid}_hlavbseq_result_${digit}.txt
sed -i 's/:x1//g' ${output_path}/${ngsid}_hlavbseq_result_${digit}.txt
rm ${output_path}/${ngsid}_hlavbseq_report_${digit}_temp.txt



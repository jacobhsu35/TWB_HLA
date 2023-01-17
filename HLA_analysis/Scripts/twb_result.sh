#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
ngsid=$3
hlaid=$4
output_path=${5}/${data_type}_twb/${preprocess_tool}_twb/${ngsid}/Results
mkdir -p $output_path

if [[ $hlaid =~ "HLA1" ]]
then
        hla_file=$hlaid".typing.csv"
else
        if [[ $hlaid =~ "HLA3" ]] || [[ $hlaid =~ "HLA4" ]]
        then
                hla_file=$hlaid".csv"
        fi
fi

input_csv=/staging/biodata/lions/twbk/*/HLAtyping/individual/*/$hla_file

awk -F ',' ' {print $5"$"$8}' $input_csv > ${output_path}/${ngsid}_twb_report_temp.txt
sed -i 's/\"//g' ${output_path}/${ngsid}_twb_report_temp.txt
egrep -n "^A" ${output_path}/${ngsid}_twb_report_temp.txt > ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$A*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
egrep -n "^B" ${output_path}/${ngsid}_twb_report_temp.txt >> ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$B*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
egrep -n "^C" ${output_path}/${ngsid}_twb_report_temp.txt >> ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$C*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
egrep -n "^DPA1" ${output_path}/${ngsid}_twb_report_temp.txt >> ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$DPA1*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
egrep -n "^DPB1" ${output_path}/${ngsid}_twb_report_temp.txt >> ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$DPB1*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
egrep -n "^DQA1" ${output_path}/${ngsid}_twb_report_temp.txt >> ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$DQA1*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
egrep -n "^DQB1" ${output_path}/${ngsid}_twb_report_temp.txt >> ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$DQB1*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
egrep -n "^DRB1" ${output_path}/${ngsid}_twb_report_temp.txt >> ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/\//$DRB1*/g' ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/^[0-9]://g' ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i 's/^[0-9][0-9]://g' ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i  's/\$/\n/g' ${output_path}/${ngsid}_twb_report_Temp.txt
sed -i  's/\=/\n/g' ${output_path}/${ngsid}_twb_report_Temp.txt
sort  ${output_path}/${ngsid}_twb_report_Temp.txt > ${output_path}/${ngsid}_twb_report.txt
sed -i '/^\s*$/d' ${output_path}/${ngsid}_twb_report.txt
sed -i 's/*/-/g' ${output_path}/${ngsid}_twb_report.txt
rm ${output_path}/${ngsid}_twb_report_temp.txt
rm ${output_path}/${ngsid}_twb_report_Temp.txt


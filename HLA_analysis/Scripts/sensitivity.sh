#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
tool_1=$3
tool_2=$4
digit=$5
sample_number=$6
output_path=$7
input_pm=${7}/${data_type}_${tool_1}/${preprocess_tool}_${tool_1}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
input_npm=${7}/${data_type}_${tool_1}/${preprocess_tool}_${tool_1}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
mkdir -p $output_path
touch ${output_path}/sensitivity_with_${tool_2}_${sample_number}.txt

echo -e "$data_type/$preprocess_tool/$digit\tHLA-A\tHLA-B\tHLA-C\tHLA-DPA1\tHLA-DPB1\tHLA-DQA1\tHLA-DQB1\tHLA-DRB1" >> ${output_path}/sensitivity_with_${tool_2}_${sample_number}.txt

A_PM=$(cat $input_pm |grep "HLA-A" |wc -l)
A_NPM=$(cat $input_npm |grep "HLA-A" |grep "Non perfect match" |wc -l)
A_SUM=$((($A_PM+$A_NPM)*2))
A_PCT=$(echo |awk -v val1=$A_PM -v val2=$A_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

B_PM=$(cat $input_pm |grep "HLA-B" |wc -l)
B_NPM=$(cat $input_npm |grep "HLA-B" |grep "Non perfect match" |wc -l)
B_SUM=$((($B_PM+$B_NPM)*2))
B_PCT=$(echo |awk -v val1=$B_PM -v val2=$B_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

C_PM=$(cat $input_pm |grep "HLA-C" |wc -l)
C_NPM=$(cat $input_npm |grep "HLA-C" |grep "Non perfect match" |wc -l)
C_SUM=$((($C_PM+$C_NPM)*2))
C_PCT=$(echo |awk -v val1=$C_PM -v val2=$C_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

DPA1_PM=$(cat $input_pm |grep "HLA-DPA1" |wc -l)
DPA1_NPM=$(cat $input_npm |grep "HLA-DPA1" |grep "Non perfect match" |wc -l)
DPA1_SUM=$((($DPA1_PM+$DPA1_NPM)*2))
DPA1_PCT=$(echo |awk -v val1=$DPA1_PM -v val2=$DPA1_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

DPB1_PM=$(cat $input_pm |grep "HLA-DPB1" |wc -l)
DPB1_NPM=$(cat $input_npm |grep "HLA-DPB1" |grep "Non perfect match" |wc -l)
DPB1_SUM=$((($DPB1_PM+$DPB1_NPM)*2))
DPB1_PCT=$(echo |awk -v val1=$DPB1_PM -v val2=$DPB1_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

DQA1_PM=$(cat $input_pm |grep "HLA-DQA1" |wc -l)
DQA1_NPM=$(cat $input_npm |grep "HLA-DQA1" |grep "Non perfect match" |wc -l)
DQA1_SUM=$((($DQA1_PM+$DQA1_NPM)*2))
DQA1_PCT=$(echo |awk -v val1=$DQA1_PM -v val2=$DQA1_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

DQB1_PM=$(cat $input_pm |grep "HLA-DQB1" |wc -l)
DQB1_NPM=$(cat $input_npm |grep "HLA-DQB1" |grep "Non perfect match" |wc -l)
DQB1_SUM=$((($DQB1_PM+$DQB1_NPM)*2))
DQB1_PCT=$(echo |awk -v val1=$DQB1_PM -v val2=$DQB1_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

DRB1_PM=$(cat $input_pm |grep "HLA-DRB1" |wc -l)
DRB1_NPM=$(cat $input_npm |grep "HLA-DRB1" |grep "Non perfect match" |wc -l)
DRB1_SUM=$((($DRB1_PM+$DRB1_NPM)*2))
DRB1_PCT=$(echo |awk -v val1=$DRB1_PM -v val2=$DRB1_SUM '{ printf "%0.2f\n" ,val1*2/val2}')

echo -e "$tool_1\t$A_PCT($(($A_PM*2))/$A_SUM)\t$B_PCT($(($B_PM*2))/$B_SUM)\t$C_PCT($(($C_PM*2))/$C_SUM)\t$DPA1_PCT($(($DPA1_PM*2))/$DPA1_SUM)\t$DPB1_PCT($(($DPB1_PM*2))/$DPB1_SUM)\t$DQA1_PCT($(($DQA1_PM*2))/$DQA1_SUM)\t$DQB1_PCT($(($DQB1_PM*2))/$DQB1_SUM)\t$DRB1_PCT($(($DRB1_PM*2))/$DRB1_SUM)" >> ${output_path}/sensitivity_with_${tool_2}_${sample_number}.txt

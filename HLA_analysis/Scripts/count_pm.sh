#!/usr/bin/bash
data_type=$1
preprocess_tool=$2
tool_1=$3
tool_2=$4
ngsid=$5
digit=$6
sample_number=$7
output_path=${8}/${data_type}_${tool_1}/${preprocess_tool}_${tool_1}/${ngsid}/Results
input_txt=${8}/${data_type}_${tool_1}/${preprocess_tool}_${tool_1}/${ngsid}/Results/${ngsid}_${tool_1}_${tool_2}_compare_${digit}.txt
output_path=${8}/${data_type}_${tool_1}/${preprocess_tool}_${tool_1}
mkdir -p $output_path
touch ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt

if ! grep  "gene" ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
then
	echo -e "sample\tgene\tperfect match count" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: A-" $input_txt && grep  "Haplotype 2: A-" $input_txt
then
	echo -e "$ngsid\tHLA-A\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: B-" $input_txt && grep  "Haplotype 2: B-" $input_txt
then
        echo -e "$ngsid\tHLA-B\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: C-" $input_txt && grep  "Haplotype 2: C-" $input_txt
then
        echo -e "$ngsid\tHLA-C\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: DPA1-" $input_txt && grep  "Haplotype 2: DPA1-" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: DPB1-" $input_txt && grep  "Haplotype 2: DPB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: DQA1-" $input_txt && grep  "Haplotype 2: DQA1-" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: DQB1-" $input_txt && grep  "Haplotype 2: DQB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

if grep  "Haplotype 1: DRB1-" $input_txt && grep  "Haplotype 2: DRB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\t1" >> ${output_path}/${tool_1}_${tool_2}_count_pm_${digit}_${sample_number}.txt
fi

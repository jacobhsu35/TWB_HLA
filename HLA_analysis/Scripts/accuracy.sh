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

touch ${output_path}/accuracy_with_${tool_2}_${sample_number}.txt
touch ${output_path}/accinfo_with_${tool_2}_${sample_number}.txt
touch ${output_path}/matchinfo_with_${tool_2}_${sample_number}.txt

if grep  "Sensitivity" ${output_path}/accuracy_with_${tool_2}_${sample_number}.txt
then
        echo "OK"
else
        echo -e "Sensitivity,Specificity,Positive predictive value (PPV),Negative predictive value (NPV),Accuracy" >> ${output_path}/accuracy_with_${tool_2}_${sample_number}.txt
fi

if grep  "Sensitivity" ${output_path}/accinfo_with_${tool_2}_${sample_number}.txt
then
        echo "OK"
else
        echo -e "True positive(TP),False negative(FN),False positive(FP),True negative(TN),Sensitivity,Specificity,Positive predictive value(PPV),Negative predictive value(NPV),Accuracy,Non field match(NFM)_high resolution_query,Non field match(NFM)_high resolution_true,Non field match(NFM)_same resolution" >> ${output_path}/accinfo_with_${tool_2}_${sample_number}.txt
fi

echo -e "$data_type/$preprocess_tool/$digit\tHLA-A\tHLA-B\tHLA-C\tHLA-DPA1\tHLA-DPB1\tHLA-DQA1\tHLA-DQB1\tHLA-DRB1" >> ${output_path}/accuracy_with_${tool_2}_${sample_number}.txt
echo -e "$data_type/$preprocess_tool/$digit\tHLA-A\tHLA-B\tHLA-C\tHLA-DPA1\tHLA-DPB1\tHLA-DQA1\tHLA-DQB1\tHLA-DRB1" >> ${output_path}/accinfo_with_${tool_2}_${sample_number}.txt
echo -e "$data_type/$preprocess_tool/$tool_1/$digit\tHLA-A,HLA-B,HLA-C,HLA-DPA1,HLA-DPB1,HLA-DQA1,HLA-DQB1,HLA-DRB1" >> ${output_path}/matchinfo_with_${tool_2}_${sample_number}.txt

A_NFM_Q=$(cat $input_npm |grep "HLA-A" |grep -P "Field match\tNon field match" |wc -l)
A_NFM_T=$(cat $input_npm |grep "HLA-A" |grep -P "Non field match\tField match" |wc -l)
A_NFM=$(cat $input_npm |grep "HLA-A" |grep -P "Non field match\tNon field match" |wc -l)
A_TP=$(cat $input_pm |grep "HLA-A" |wc -l)
A_FN=$(cat $input_npm |grep "HLA-A" |grep "Non perfect match" |wc -l)
A_FP=$(cat $input_npm |grep "HLA-A" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
A_TN=$(cat $input_npm |grep "HLA-A" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
A_sensitivity=$(echo |awk -v val1=$A_TP -v val2=$A_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
A_specificity=$(echo |awk -v val1=$A_TN -v val2=$A_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
A_PPV=$(echo |awk -v val1=$A_TP -v val2=$A_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
A_NPV=$(echo |awk -v val1=$A_TN -v val2=$A_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
A_ACC=$(echo |awk -v val1=$A_TP -v val2=$A_TN -v val3=$A_FP -v val4=$A_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

B_NFM_Q=$(cat $input_npm |grep "HLA-B" |grep -P "Field match\tNon field match" |wc -l)
B_NFM_T=$(cat $input_npm |grep "HLA-B" |grep -P "Non field match\tField match" |wc -l)
B_NFM=$(cat $input_npm |grep "HLA-B" |grep -P "Non field match\tNon field match" |wc -l)
B_TP=$(cat $input_pm |grep "HLA-B" |wc -l)
B_FN=$(cat $input_npm |grep "HLA-B" |grep "Non perfect match" |wc -l)
B_FP=$(cat $input_npm |grep "HLA-B" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
B_TN=$(cat $input_npm |grep "HLA-B" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
B_sensitivity=$(echo |awk -v val1=$B_TP -v val2=$B_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
B_specificity=$(echo |awk -v val1=$B_TN -v val2=$B_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
B_PPV=$(echo |awk -v val1=$B_TP -v val2=$B_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
B_NPV=$(echo |awk -v val1=$B_TN -v val2=$B_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
B_ACC=$(echo |awk -v val1=$B_TP -v val2=$B_TN -v val3=$B_FP -v val4=$B_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

C_NFM_Q=$(cat $input_npm |grep "HLA-C" |grep -P "Field match\tNon field match" |wc -l)
C_NFM_T=$(cat $input_npm |grep "HLA-C" |grep -P "Non field match\tField match" |wc -l)
C_NFM=$(cat $input_npm |grep "HLA-C" |grep -P "Non field match\tNon field match" |wc -l)
C_TP=$(cat $input_pm |grep "HLA-C" |wc -l)
C_FN=$(cat $input_npm |grep "HLA-C" |grep "Non perfect match" |wc -l)
C_FP=$(cat $input_npm |grep "HLA-C" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
C_TN=$(cat $input_npm |grep "HLA-C" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
C_sensitivity=$(echo |awk -v val1=$C_TP -v val2=$C_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
C_specificity=$(echo |awk -v val1=$C_TN -v val2=$C_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
C_PPV=$(echo |awk -v val1=$C_TP -v val2=$C_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
C_NPV=$(echo |awk -v val1=$C_TN -v val2=$C_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
C_ACC=$(echo |awk -v val1=$C_TP -v val2=$C_TN -v val3=$C_FP -v val4=$C_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

DPA1_NFM_Q=$(cat $input_npm |grep "HLA-DPA1" |grep -P "Field match\tNon field match" |wc -l)
DPA1_NFM_T=$(cat $input_npm |grep "HLA-DPA1" |grep -P "Non field match\tField match" |wc -l)
DPA1_NFM=$(cat $input_npm |grep "HLA-DPA1" |grep -P "Non field match\tNon field match" |wc -l)
DPA1_TP=$(cat $input_pm |grep "HLA-DPA1" |wc -l)
DPA1_FN=$(cat $input_npm |grep "HLA-DPA1" |grep "Non perfect match" |wc -l)
DPA1_FP=$(cat $input_npm |grep "HLA-DPA1" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
DPA1_TN=$(cat $input_npm |grep "HLA-DPA1" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
DPA1_sensitivity=$(echo |awk -v val1=$DPA1_TP -v val2=$DPA1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPA1_specificity=$(echo |awk -v val1=$DPA1_TN -v val2=$DPA1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPA1_PPV=$(echo |awk -v val1=$DPA1_TP -v val2=$DPA1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPA1_NPV=$(echo |awk -v val1=$DPA1_TN -v val2=$DPA1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPA1_ACC=$(echo |awk -v val1=$DPA1_TP -v val2=$DPA1_TN -v val3=$DPA1_FP -v val4=$DPA1_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

DPB1_NFM_Q=$(cat $input_npm |grep "HLA-DPB1" |grep -P "Field match\tNon field match" |wc -l)
DPB1_NFM_T=$(cat $input_npm |grep "HLA-DPB1" |grep -P "Non field match\tField match" |wc -l)
DPB1_NFM=$(cat $input_npm |grep "HLA-DPB1" |grep -P "Non field match\tNon field match" |wc -l)
DPB1_TP=$(cat $input_pm |grep "HLA-DPB1" |wc -l)
DPB1_FN=$(cat $input_npm |grep "HLA-DPB1" |grep "Non perfect match" |wc -l)
DPB1_FP=$(cat $input_npm |grep "HLA-DPB1" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
DPB1_TN=$(cat $input_npm |grep "HLA-DPB1" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
DPB1_sensitivity=$(echo |awk -v val1=$DPB1_TP -v val2=$DPB1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPB1_specificity=$(echo |awk -v val1=$DPB1_TN -v val2=$DPB1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPB1_PPV=$(echo |awk -v val1=$DPB1_TP -v val2=$DPB1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPB1_NPV=$(echo |awk -v val1=$DPB1_TN -v val2=$DPB1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DPB1_ACC=$(echo |awk -v val1=$DPB1_TP -v val2=$DPB1_TN -v val3=$DPB1_FP -v val4=$DPB1_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

DQA1_NFM_Q=$(cat $input_npm |grep "HLA-DQA1" |grep -P "Field match\tNon field match" |wc -l)
DQA1_NFM_T=$(cat $input_npm |grep "HLA-DQA1" |grep -P "Non field match\tField match" |wc -l)
DQA1_NFM=$(cat $input_npm |grep "HLA-DQA1" |grep -P "Non field match\tNon field match" |wc -l)
DQA1_TP=$(cat $input_pm |grep "HLA-DQA1" |wc -l)
DQA1_FN=$(cat $input_npm |grep "HLA-DQA1" |grep "Non perfect match" |wc -l)
DQA1_FP=$(cat $input_npm |grep "HLA-DQA1" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
DQA1_TN=$(cat $input_npm |grep "HLA-DQA1" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
DQA1_sensitivity=$(echo |awk -v val1=$DQA1_TP -v val2=$DQA1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQA1_specificity=$(echo |awk -v val1=$DQA1_TN -v val2=$DQA1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQA1_PPV=$(echo |awk -v val1=$DQA1_TP -v val2=$DQA1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQA1_NPV=$(echo |awk -v val1=$DQA1_TN -v val2=$DQA1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQA1_ACC=$(echo |awk -v val1=$DQA1_TP -v val2=$DQA1_TN -v val3=$DQA1_FP -v val4=$DQA1_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

DQB1_NFM_Q=$(cat $input_npm |grep "HLA-DQB1" |grep -P "Field match\tNon field match" |wc -l)
DQB1_NFM_T=$(cat $input_npm |grep "HLA-DQB1" |grep -P "Non field match\tField match" |wc -l)
DQB1_NFM=$(cat $input_npm |grep "HLA-DQB1" |grep -P "Non field match\tNon field match" |wc -l)
DQB1_TP=$(cat $input_pm |grep "HLA-DQB1" |wc -l)
DQB1_FN=$(cat $input_npm |grep "HLA-DQB1" |grep "Non perfect match" |wc -l)
DQB1_FP=$(cat $input_npm |grep "HLA-DQB1" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
DQB1_TN=$(cat $input_npm |grep "HLA-DQB1" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
DQB1_sensitivity=$(echo |awk -v val1=$DQB1_TP -v val2=$DQB1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQB1_specificity=$(echo |awk -v val1=$DQB1_TN -v val2=$DQB1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQB1_PPV=$(echo |awk -v val1=$DQB1_TP -v val2=$DQB1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQB1_NPV=$(echo |awk -v val1=$DQB1_TN -v val2=$DQB1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DQB1_ACC=$(echo |awk -v val1=$DQB1_TP -v val2=$DQB1_TN -v val3=$DQB1_FP -v val4=$DQB1_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

DRB1_NFM_Q=$(cat $input_npm |grep "HLA-DRB1" |grep -P "Field match\tNon field match" |wc -l)
DRB1_NFM_T=$(cat $input_npm |grep "HLA-DRB1" |grep -P "Non field match\tField match" |wc -l)
DRB1_NFM=$(cat $input_npm |grep "HLA-DRB1" |grep -P "Non field match\tNon field match" |wc -l)
DRB1_TP=$(cat $input_pm |grep "HLA-DRB1" |wc -l)
DRB1_FN=$(cat $input_npm |grep "HLA-DRB1" |grep "Non perfect match" |wc -l)
DRB1_FP=$(cat $input_npm |grep "HLA-DRB1" |grep -P -e "More\tOne|One\tMore|No call\tOne|One\tNo call|Field match\tNon field match|Non field match\tField match" |wc -l)
DRB1_TN=$(cat $input_npm |grep "HLA-DRB1" |grep -P -e "More\tNo call|No call\tMore|More\tMore|No call\tNo call|Non field match\tNon field match" |wc -l)
DRB1_sensitivity=$(echo |awk -v val1=$DRB1_TP -v val2=$DRB1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DRB1_specificity=$(echo |awk -v val1=$DRB1_TN -v val2=$DRB1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DRB1_PPV=$(echo |awk -v val1=$DRB1_TP -v val2=$DRB1_FP '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DRB1_NPV=$(echo |awk -v val1=$DRB1_TN -v val2=$DRB1_FN '{ printf "%0.2f\n" ,val1/(val1+val2)}')
DRB1_ACC=$(echo |awk -v val1=$DRB1_TP -v val2=$DRB1_TN -v val3=$DRB1_FP -v val4=$DRB1_FN '{ printf "%0.2f\n" ,(val1+val2)/(val1+val2+val3+val4)}')

echo -e "$tool_1\t$A_sensitivity($A_TP/$(($A_TP+$A_FN))),$A_specificity($A_TN/$(($A_TN+$A_FP))),$A_PPV($A_TP/$(($A_TP+$A_FP))),$A_NPV($A_TN/$(($A_TN+$A_FN))),$A_ACC($(($A_TP+$A_TN))/$(($A_TP+$A_TN+$A_FP+$A_FN)))\t$B_sensitivity($B_TP/$(($B_TP+$B_FN))),$B_specificity($B_TN/$(($B_TN+$B_FP))),$B_PPV($B_TP/$(($B_TP+$B_FP))),$B_NPV($B_TN/$(($B_TN+$B_FN))),$B_ACC($(($B_TP+$B_TN))/$(($B_TP+$B_TN+$B_FP+$B_FN)))\t$C_sensitivity($C_TP/$(($C_TP+$C_FN))),$C_specificity($C_TN/$(($C_TN+$C_FP))),$C_PPV($C_TP/$(($C_TP+$C_FP))),$C_NPV($C_TN/$(($C_TN+$C_FN))),$C_ACC($(($C_TP+$C_TN))/$(($C_TP+$C_TN+$C_FP+$C_FN)))\t$DPA1_sensitivity($DPA1_TP/$(($DPA1_TP+$DPA1_FN))),$DPA1_specificity($DPA1_TN/$(($DPA1_TN+$DPA1_FP))),$DPA1_PPV($DPA1_TP/$(($DPA1_TP+$DPA1_FP))),$DPA1_NPV($DPA1_TN/$(($DPA1_TN+$DPA1_FN))),$DPA1_ACC($(($DPA1_TP+$DPA1_TN))/$(($DPA1_TP+$DPA1_TN+$DPA1_FP+$DPA1_FN)))\t$DPB1_sensitivity($DPB1_TP/$(($DPB1_TP+$DPB1_FN))),$DPB1_specificity($DPB1_TN/$(($DPB1_TN+$DPB1_FP))),$DPB1_PPV($DPB1_TP/$(($DPB1_TP+$DPB1_FP))),$DPB1_NPV($DPB1_TN/$(($DPB1_TN+$DPB1_FN))),$DPB1_ACC($(($DPB1_TP+$DPB1_TN))/$(($DPB1_TP+$DPB1_TN+$DPB1_FP+$DPB1_FN)))\t$DQA1_sensitivity($DQA1_TP/$(($DQA1_TP+$DQA1_FN))),$DQA1_specificity($DQA1_TN/$(($DQA1_TN+$DQA1_FP))),$DQA1_PPV($DQA1_TP/$(($DQA1_TP+$DQA1_FP))),$DQA1_NPV($DQA1_TN/$(($DQA1_TN+$DQA1_FN))),$DQA1_ACC($(($DQA1_TP+$DQA1_TN))/$(($DQA1_TP+$DQA1_TN+$DQA1_FP+$DQA1_FN)))\t$DQB1_sensitivity($DQB1_TP/$(($DQB1_TP+$DQB1_FN))),$DQB1_specificity($DQB1_TN/$(($DQB1_TN+$DQB1_FP))),$DQB1_PPV($DQB1_TP/$(($DQB1_TP+$DQB1_FP))),$DQB1_NPV($DQB1_TN/$(($DQB1_TN+$DQB1_FN))),$DQB1_ACC($(($DQB1_TP+$DQB1_TN))/$(($DQB1_TP+$DQB1_TN+$DQB1_FP+$DQB1_FN)))\t$DRB1_sensitivity($DRB1_TP/$(($DRB1_TP+$DRB1_FN))),$DRB1_specificity($DRB1_TN/$(($DRB1_TN+$DRB1_FP))),$DRB1_PPV($DRB1_TP/$(($DRB1_TP+$DRB1_FP))),$DRB1_NPV($DRB1_TN/$(($DRB1_TN+$DRB1_FN))),$DRB1_ACC($(($DRB1_TP+$DRB1_TN))/$(($DRB1_TP+$DRB1_TN+$DRB1_FP+$DRB1_FN)))" >> ${output_path}/accuracy_with_${tool_2}_${sample_number}.txt

echo -e "$tool_1\t$A_TP,$A_FN,$A_FP,$A_TN,$A_sensitivity,$A_specificity,$A_PPV,$A_NPV,$A_ACC,$A_NFM_Q,$A_NFM_T,$A_NFM\t$B_TP,$B_FN,$B_FP,$B_TN,$B_sensitivity,$B_specificity,$B_PPV,$B_NPV,$B_ACC,$B_NFM_Q,$B_NFM_T,$B_NFM\t$C_TP,$C_FN,$C_FP,$C_TN,$C_sensitivity,$C_specificity,$C_PPV,$C_NPV,$C_ACC,$C_NFM_Q,$C_NFM_T,$C_NFM\t$DPA1_TP,$DPA1_FN,$DPA1_FP,$DPA1_TN,$DPA1_sensitivity,$DPA1_specificity,$DPA1_PPV,$DPA1_NPV,$DPA1_ACC,$DPA1_NFM_Q,$DPA1_NFM_T,$DPA1_NFM\t$DPB1_TP,$DPB1_FN,$DPB1_FP,$DPB1_TN,$DPB1_sensitivity,$DPB1_specificity,$DPB1_PPV,$DPB1_NPV,$DPB1_ACC,$DPB1_NFM_Q,$DPB1_NFM_T,$DPB1_NFM\t$DQA1_TP,$DQA1_FN,$DQA1_FP,$DQA1_TN,$DQA1_sensitivity,$DQA1_specificity,$DQA1_PPV,$DQA1_NPV,$DQA1_ACC,$DQA1_NFM_Q,$DQA1_NFM_T,$DQA1_NFM\t$DQB1_TP,$DQB1_FN,$DQB1_FP,$DQB1_TN,$DQB1_sensitivity,$DQB1_specificity,$DQB1_PPV,$DQB1_NPV,$DQB1_ACC,$DQB1_NFM_Q,$DQB1_NFM_T,$DQB1_NFM\t$DRB1_TP,$DRB1_FN,$DRB1_FP,$DRB1_TN,$DRB1_sensitivity,$DRB1_specificity,$DRB1_PPV,$DRB1_NPV,$DRB1_ACC,$DRB1_NFM_Q,$DRB1_NFM_T,$DRB1_NFM" >> ${output_path}/accinfo_with_${tool_2}_${sample_number}.txt

echo -e "Perfect_match\t[$(($A_TP*2)),$(($B_TP*2)),$(($C_TP*2)),$(($DPA1_TP*2)),$(($DPB1_TP*2)),$(($DQA1_TP*2)),$(($DQB1_TP*2)),$(($DRB1_TP*2))]" >> ${output_path}/matchinfo_with_${tool_2}_${sample_number}.txt
echo -e "Non_perfect_match\t[$(($A_FN*2)),$(($B_FN*2)),$(($C_FN*2)),$(($DPA1_FN*2)),$(($DPB1_FN*2)),$(($DQA1_FN*2)),$(($DQB1_FN*2)),$(($DRB1_FN*2))]" >> ${output_path}/matchinfo_with_${tool_2}_${sample_number}.txt
echo -e "Uncomparable\t[$((($A_FP+$A_TN)*2)),$((($B_FP+$B_TN)*2)),$((($C_FP+$C_TN)*2)),$((($DPA1_FP+$DPA1_TN)*2)),$((($DPB1_FP+$DPB1_TN)*2)),$((($DQA1_FP+$DQA1_TN)*2)),$((($DQB1_FP+$DQB1_TN)*2)),$((($DRB1_FP+$DRB1_TN)*2))]" >> ${output_path}/matchinfo_with_${tool_2}_${sample_number}.txt
echo -e "Sensitivity\t[$(echo "$A_sensitivity*100" |bc |cut -d. -f1),$(echo "$B_sensitivity*100" |bc |cut -d. -f1),$(echo "$C_sensitivity*100" |bc |cut -d. -f1),$(echo "$DPA1_sensitivity*100" |bc |cut -d. -f1),$(echo "$DPB1_sensitivity*100" |bc |cut -d. -f1),$(echo "$DQA1_sensitivity*100" |bc |cut -d. -f1),$(echo "$DQB1_sensitivity*100" |bc |cut -d. -f1),$(echo "$DRB1_sensitivity*100" |bc |cut -d. -f1)]" >> ${output_path}/matchinfo_with_${tool_2}_${sample_number}.txt


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
touch ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt

if ! grep  "gene" ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
then
        echo -e "sample\tgene\t${tool_1}\t${tool_2}\tnote" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: A-" $input_txt &&  grep  "Haplotype 2: A-" $input_txt
then
        echo -e "perfect match"
elif grep  "^A-" $input_txt
then
        echo -e "$ngsid\tHLA-A\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-A\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-A\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-A\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-A\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-A\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-A\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-A\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-A\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-A\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-A\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^A: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-A\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: A-" $input_txt ||  grep  "Haplotype 2: A-" $input_txt
then
        echo -e "$ngsid\tHLA-A\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
	echo -e "$ngsid\tHLA-A\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: B-" $input_txt &&  grep  "Haplotype 2: B-" $input_txt
then
        echo -e "perfect match"
elif grep  "^B-" $input_txt
then
        echo -e "$ngsid\tHLA-B\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-B\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-B\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-B\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-B\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-B\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-B\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-B\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-B\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-B\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-B\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^B: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-B\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: B-" $input_txt ||  grep  "Haplotype 2: B-" $input_txt
then
        echo -e "$ngsid\tHLA-B\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
        echo -e "$ngsid\tHLA-B\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: C-" $input_txt &&  grep  "Haplotype 2: C-" $input_txt
then
        echo -e "perfect match"
elif grep  "^C-" $input_txt
then
        echo -e "$ngsid\tHLA-C\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-C\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-C\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-C\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-C\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-C\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-C\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-C\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-C\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-C\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-C\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^C: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-C\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: C-" $input_txt ||  grep  "Haplotype 2: C-" $input_txt
then
        echo -e "$ngsid\tHLA-C\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
        echo -e "$ngsid\tHLA-C\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: DPA1-" $input_txt &&  grep  "Haplotype 2: DPA1-" $input_txt
then
        echo -e "perfect match"
elif grep  "^DPA1-" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPA1: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: DPA1-" $input_txt ||  grep  "Haplotype 2: DPA1-" $input_txt
then
        echo -e "$ngsid\tHLA-DPA1\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
        echo -e "$ngsid\tHLA-DPA1\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: DPB1-" $input_txt &&  grep  "Haplotype 2: DPB1-" $input_txt
then
        echo -e "perfect match"
elif grep  "^DPB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DPB1: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: DPB1-" $input_txt ||  grep  "Haplotype 2: DPB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DPB1\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
        echo -e "$ngsid\tHLA-DPB1\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: DQA1-" $input_txt &&  grep  "Haplotype 2: DQA1-" $input_txt
then
        echo -e "perfect match"
elif grep  "^DQA1-" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQA1: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: DQA1-" $input_txt ||  grep  "Haplotype 2: DQA1-" $input_txt
then
        echo -e "$ngsid\tHLA-DQA1\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
        echo -e "$ngsid\tHLA-DQA1\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: DQB1-" $input_txt &&  grep  "Haplotype 2: DQB1-" $input_txt
then
        echo -e "perfect match"
elif grep  "^DQB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DQB1: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: DQB1-" $input_txt ||  grep  "Haplotype 2: DQB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DQB1\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
        echo -e "$ngsid\tHLA-DQB1\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi

if  grep  "Haplotype 1: DRB1-" $input_txt &&  grep  "Haplotype 2: DRB1-" $input_txt
then
        echo -e "perfect match"
elif grep  "^DRB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tOne\tOne\tNon perfect match(Two alleles)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: one to more" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tOne\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: more to one" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tMore\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: more to more" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tMore\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: one to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tOne\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: no call to one" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tNo call\tOne" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: more to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tMore\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: no call to more" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tNo call\tMore" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: no call to no call" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tNo call\tNo call" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tField match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: non field match to field match" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tNon field match\tField match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif grep  "^DRB1: non field match to non field match" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tNon field match\tNon field match" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
elif  grep  "Haplotype 1: DRB1-" $input_txt ||  grep  "Haplotype 2: DRB1-" $input_txt
then
        echo -e "$ngsid\tHLA-DRB1\tOne\tOne\tNon perfect match (One allele)" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
else
        echo -e "$ngsid\tHLA-DRB1\tUnknown\tUnknown\tNot applicable" >> ${output_path}/${tool_1}_${tool_2}_count_npm_${digit}_${sample_number}.txt
fi


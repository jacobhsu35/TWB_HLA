#!/usr/bin/bash
data_type_1=${1}
data_type_2=${2}
preprocess_tool_1=${3}
preprocess_tool_2=${4}
Output=${5}
Sample=$(cd `dirname $0`; cd .. ; pwd)/Lists/${6}.txt
Gene=$(cd `dirname $0`; cd .. ; pwd)/Lists/gene_list.txt
sample_number=${7}
input_pm_txt=$(cd `dirname $0`; cd .. ; pwd)/Lists/hisatgenotype_pm_pool_d4_879.txt
input_npm_txt=$(cd `dirname $0`; cd .. ; pwd)/Lists/hisatgenotype_npm_pool_d4_879.txt

touch ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
if ! grep  "Label" ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
then
	echo -e "Sample,HLA-A(HISAT-genotype),Label,HLA-A(HISAT-genotype),Label,HLA-B(HISAT-genotype),Label,HLA-B(HISAT-genotype),Label,HLA-C(HISAT-genotype),Label,HLA-C(HISAT-genotype),Label,HLA-DPA1(HISAT-genotype),Label,HLA-DPA1(HISAT-genotype),Label,HLA-DPB1(HISAT-genotype),Label,HLA-DPB1(HISAT-genotype),Label,HLA-DQA1(HISAT-genotype),Label,HLA-DQA1(HISAT-genotype),Label,HLA-DQB1(HISAT-genotype),Label,HLA-DQB1(HISAT-genotype),Label,HLA-DRB1(HISAT-genotype),Label,HLA-DRB1(HISAT-genotype),Label,HLA-C(HLA-VBSeq),HLA-C(HLA-VBSeq),HLA-DPA1(HLA-VBSeq),HLA-DPA1(HLA-VBSeq)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
fi

c1_1=0
c1_2=0
c1_3=0
c2_1=0
c2_2=0
c2_3=0
c3_1=0
c3_2=0
c3_3=0
c4_1=0
c4_2=0
c4_3=0
c1=0
c2=0
c3=0
c4=0
while read line_1;
	do

		H=${Output}/${data_type_1}_hisatgenotype/${preprocess_tool_1}_hisatgenotype/${line_1}/Results/${line_1}_hisatgenotype_result_d4.txt
		V=${Output}/${data_type_2}_hlavbseq/${preprocess_tool_2}_hlavbseq/${line_1}/Results/${line_1}_hlavbseq_result_d4.txt

		V_H1=$(sort $V |grep ^C | head -n 1)
		V_H2=$(sort $V |grep ^C | head | tail -n 1)
		V_H3=$(sort $V |grep ^DPA1 | head -n 1)
                V_H4=$(sort $V |grep ^DPA1 | head | tail -n 1)
		predict=$line_1
		while read line_2;
        		do
				H_H1=$(sort $H |grep ^${line_2} | head -n 1)
				H_H2=$(sort $H |grep ^${line_2} | head | tail -n 1)
				if grep  $H_H1/$H_H2 $input_pm_txt
				then
					if grep $H_H1/$H_H2 $input_npm_txt
                                        then
						if  [[ $H_H1 = "DPA1-02:07" ]] || [[ $H_H1 = "DRB1-12:57" ]] || [[ $H_H1 = "DRB1-09:01" ]]
						then
							H_H1_sign="ox##"
							c1_1=$(($c1_1+1))
						elif [[ $H_H1 = "C-04:01" ]] || [[ $H_H1 = "DPB1-135:01" ]]
						then
							H_H1_sign="ox#"
							c1_2=$(($c1_2+1))
						else
							H_H1_sign="ox"
							c1_3=$(($c1_3+1))
						fi
						if  [[ $H_H2 = "DPA1-02:07" ]] || [[ $H_H2 = "DRB1-12:57" ]] || [[ $H_H2 = "DRB1-09:01" ]]
						then
							H_H2_sign="ox##"
							c1_1=$(($c1_1+1))
						elif [[ $H_H2 = "C-04:01" ]] || [[ $H_H2 = "DPB1-135:01" ]]
						then
							H_H2_sign="ox#"
							c1_2=$(($c1_2+1))
						else
							H_H2_sign="ox"
							c1_3=$(($c1_3+1))
						fi
                                                c1=$(($c1+2))
					else
						if  [[ $H_H1 = "DPA1-02:07" ]] || [[ $H_H1 = "DRB1-12:57" ]] || [[ $H_H1 = "DRB1-09:01" ]]
                                                then
                                                        H_H1_sign="o##"
                                                        c2_1=$(($c2_1+1))
                                                elif [[ $H_H1 = "C-04:01" ]] || [[ $H_H1 = "DPB1-135:01" ]]
                                                then
                                                        H_H1_sign="o#"
                                                        c2_2=$(($c2_2+1))
                                                else
                                                        H_H1_sign="o"
                                                        c2_3=$(($c2_3+1))
                                                fi
                                                if  [[ $H_H2 = "DPA1-02:07" ]] || [[ $H_H2 = "DRB1-12:57" ]] || [[ $H_H2 = "DRB1-09:01" ]]
                                                then
                                                        H_H2_sign="o##"
                                                        c2_1=$(($c2_1+1))
                                                elif [[ $H_H2 = "C-04:01" ]] || [[ $H_H2 = "DPB1-135:01" ]]
                                                then
                                                        H_H2_sign="o#"
                                                        c2_2=$(($c2_2+1))
                                                else
                                                        H_H2_sign="o"
                                                        c2_3=$(($c2_3+1))
                                                fi
                                                c2=$(($c2+2))
					fi 
					mark=",$H_H1,$H_H1_sign,$H_H2,$H_H2_sign"
				elif grep  $H_H1/$H_H2 $input_npm_txt
				then
					if  [[ $H_H1 = "DPA1-02:07" ]] || [[ $H_H1 = "DRB1-12:57" ]] || [[ $H_H1 = "DRB1-09:01" ]]
					then
						H_H1_sign="x##"
						c3_1=$(($c3_1+1))
					elif [[ $H_H1 = "C-04:01" ]] || [[ $H_H1 = "DPB1-135:01" ]]
					then
						H_H1_sign="x#"
						c3_2=$(($c3_2+1))
					else
						H_H1_sign="x"
						c3_3=$(($c3_3+1))
					fi
					if  [[ $H_H2 = "DPA1-02:07" ]] || [[ $H_H2 = "DRB1-12:57" ]] || [[ $H_H2 = "DRB1-09:01" ]]
					then
						H_H2_sign="x##"
						c3_1=$(($c3_1+1))
					elif [[ $H_H2 = "C-04:01" ]] || [[ $H_H2 = "DPB1-135:01" ]]
					then
						H_H2_sign="x#"
						c3_2=$(($c3_2+1))
					else
						H_H2_sign="x"
						c3_3=$(($c3_3+1))
					fi
					c3=$(($c3+2))
					mark=",$H_H1,$H_H1_sign,$H_H2,$H_H2_sign"
						
				else
				 	if  [[ $H_H1 = "DPA1-02:07" ]] || [[ $H_H1 = "DRB1-12:57" ]] || [[ $H_H1 = "DRB1-09:01" ]]
                                        then
                                                H_H1_sign="*##"
                                                c4_1=$(($c4_1+1))
                                        elif [[ $H_H1 = "C-04:01" ]] || [[ $H_H1 = "DPB1-135:01" ]]
                                        then
                                                H_H1_sign="*#"
                                                c4_2=$(($c4_2+1))
                                        else
                                                H_H1_sign="*"
                                                c4_3=$(($c4_3+1))
                                        fi
                                        if  [[ $H_H2 = "DPA1-02:07" ]] || [[ $H_H2 = "DRB1-12:57" ]] || [[ $H_H2 = "DRB1-09:01" ]]
                                        then
                                                H_H2_sign="*##"
                                                c4_1=$(($c4_1+1))
                                        elif [[ $H_H2 = "C-04:01" ]] || [[ $H_H2 = "DPB1-135:01" ]]
                                        then
                                                H_H2_sign="*#"
                                                c4_2=$(($c4_2+1))
                                        else
                                                H_H2_sign="*"
                                                c4_3=$(($c4_3+1))
                                        fi	
					c4=$(($c4+2))
					mark=",$H_H1,$H_H1_sign,$H_H2,$H_H2_sign"
				fi
				predict=$predict$mark
			done <$Gene
			echo -e "$predict,$V_H1,$V_H2,$V_H3,$V_H4" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv	
	done <$Sample

sum_33=$(($c1_1+$c2_1+$c3_1+$c4_1))
sum_3=$(($c1_2+$c2_2+$c3_2+$c4_2))

sum_u=$(($c1_1+$c1_2+$c1_3+$c2_1+$c2_2+$c2_3+$c3_1+$c3_2+$c3_3+$c4_1+$c4_2+$c4_3))
sum_p=$(($c1+$c2+$c3+$c4))
mo_pct=$(echo |awk -v val1=$c2 -v val2=$sum_p '{ printf "%0.2f\n" ,val1/val2}')
mx_pct=$(echo |awk -v val1=$c3 -v val2=$sum_p '{ printf "%0.2f\n" ,val1/val2}')
mox_pct=$(echo |awk -v val1=$c1 -v val2=$sum_p '{ printf "%0.2f\n" ,val1/val2}')
mn_pct=$(echo |awk -v val1=$c4 -v val2=$sum_p '{ printf "%0.2f\n" ,val1/val2}')
m33_pct=$(echo |awk -v val1=$sum_33 -v val2=$sum_u '{ printf "%0.2f\n" ,val1/val2}')
m3_pct=$(echo |awk -v val1=$sum_3 -v val2=$sum_u '{ printf "%0.2f\n" ,val1/val2}')
#echo -e "o,$c1_1_pct($c1_1/$sum),o##,$c1_2_pct($c1_2/$sum),o#,$c1_3_pct($c1_3/$sum),o-,$c1_4_pct($c1_4/$sum),ox,$c1_5_pct($c1_5/$sum),##,$c2_pct($c2/$sum),#,$c3_pct($c3/$sum),-,$c4_pct($c4/$sum),+,$c5_pct($c5/$sum),*,$c6_pct($c6/$sum),x,$c1_6_pct($c1_6/$sum),x##,$c1_7_pct($c1_7/$sum),x#,$c1_8_pct($c1_8/$sum),x+,$c1_9_pct($c1_9/$sum)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv

echo -e "o,$mo_pct($c2/$sum_p)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
echo -e "x,$mx_pct($c3/$sum_p)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
echo -e "ox,$mox_pct($c1/$sum_p)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
echo -e "*,$mn_pct($c4/$sum_p)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
echo -e "##,$m33_pct($sum_33/$sum_u)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv
echo -e "#,$m3_pct($sum_3/$sum_u)" >> ${Output}/hla_genotyping_labeling_d4_${sample_number}.csv

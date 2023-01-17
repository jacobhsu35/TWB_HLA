#!/usr/bin/bash
wkdir=$(cd `dirname $0`; pwd)
output=$(cd `dirname $0`; cd .. ; pwd)/Lists/HLA_g_group
execlist=$(cd `dirname $0`; cd .. ; pwd)/Lists/${1}.txt
genelist=$(cd `dirname $0`; cd .. ; pwd)/Lists/gene_list.txt

mkdir -p $output/HLA_A_g_group
grep "^A.*G$" $execlist > $output/HLA_A_g_group/HLA_A_g_group.txt
while read line;
        do
	echo $line > $output/HLA_A_g_group/hla_A_g_group.txt
	A=$(grep "^A.*G$" $output/HLA_A_g_group/hla_A_g_group.txt | awk -F ';' ' {print "A-"$3".txt"}')
	echo $A >> $output/HLA_A_g_group/HLA_A_g_group_list.txt
	sed -i "s|.txt||g" $output/HLA_A_g_group/HLA_A_g_group_list.txt
	cat $output/HLA_A_g_group/hla_A_g_group.txt > $output/HLA_A_g_group/$A
	sed -i "s|A\*;|A-|g" $output/HLA_A_g_group/$A
	#sed -i "s|G||g" $output/HLA_A_g_group/$A
	sed -i "s|\;|%A-|g" $output/HLA_A_g_group/$A
	sed -i "s|\/|%A-|g" $output/HLA_A_g_group/$A
	sed -i "s|%|\n|g" $output/HLA_A_g_group/$A
	sed -i '/^\s*$/d' $output/HLA_A_g_group/$A
	rm $output/HLA_A_g_group/hla_A_g_group.txt
	done<$output/HLA_A_g_group/HLA_A_g_group.txt


mkdir -p $output/HLA_B_g_group
grep "^B.*G$" $execlist > $output/HLA_B_g_group/HLA_B_g_group.txt
while read line;
        do
        echo $line > $output/HLA_B_g_group/hla_B_g_group.txt
        B=$(grep "^B.*G$" $output/HLA_B_g_group/hla_B_g_group.txt | awk -F ';' ' {print "B-"$3".txt"}')
        echo $B >> $output/HLA_B_g_group/HLA_B_g_group_list.txt
        sed -i "s|.txt||g" $output/HLA_B_g_group/HLA_B_g_group_list.txt
        cat $output/HLA_B_g_group/hla_B_g_group.txt > $output/HLA_B_g_group/$B
        sed -i "s|B\*;|B-|g" $output/HLA_B_g_group/$B
        #sed -i "s|G||g" $output/HLA_B_g_group/$B
        sed -i "s|\;|%B-|g" $output/HLA_B_g_group/$B
        sed -i "s|\/|%B-|g" $output/HLA_B_g_group/$B
        sed -i "s|%|\n|g" $output/HLA_B_g_group/$B
        sed -i '/^\s*$/d' $output/HLA_B_g_group/$B
        rm $output/HLA_B_g_group/hla_B_g_group.txt
        done<$output/HLA_B_g_group/HLA_B_g_group.txt


mkdir -p $output/HLA_C_g_group
grep "^C.*G$" $execlist > $output/HLA_C_g_group/HLA_C_g_group.txt
while read line;
        do
        echo $line > $output/HLA_C_g_group/hla_C_g_group.txt
        C=$(grep "^C.*G$" $output/HLA_C_g_group/hla_C_g_group.txt | awk -F ';' ' {print "C-"$3".txt"}')
        echo $C >> $output/HLA_C_g_group/HLA_C_g_group_list.txt
        sed -i "s|.txt||g" $output/HLA_C_g_group/HLA_C_g_group_list.txt
        cat $output/HLA_C_g_group/hla_C_g_group.txt > $output/HLA_C_g_group/$C
        sed -i "s|C\*;|C-|g" $output/HLA_C_g_group/$C
        #sed -i "s|G||g" $output/HLA_C_g_group/$C
        sed -i "s|\;|%C-|g" $output/HLA_C_g_group/$C
        sed -i "s|\/|%C-|g" $output/HLA_C_g_group/$C
        sed -i "s|%|\n|g" $output/HLA_C_g_group/$C
        sed -i '/^\s*$/d' $output/HLA_C_g_group/$C
        rm $output/HLA_C_g_group/hla_C_g_group.txt
        done<$output/HLA_C_g_group/HLA_C_g_group.txt


mkdir -p $output/HLA_DPA1_g_group
grep "^DPA1.*G$" $execlist > $output/HLA_DPA1_g_group/HLA_DPA1_g_group.txt
while read line;
        do
        echo $line > $output/HLA_DPA1_g_group/hla_DPA1_g_group.txt
        DPA1=$(grep "^DPA1.*G$" $output/HLA_DPA1_g_group/hla_DPA1_g_group.txt | awk -F ';' ' {print "DPA1-"$3".txt"}')
        echo $DPA1 >> $output/HLA_DPA1_g_group/HLA_DPA1_g_group_list.txt
        sed -i "s|.txt||g" $output/HLA_DPA1_g_group/HLA_DPA1_g_group_list.txt
        cat $output/HLA_DPA1_g_group/hla_DPA1_g_group.txt > $output/HLA_DPA1_g_group/$DPA1
        sed -i "s|DPA1\*;|DPA1-|g" $output/HLA_DPA1_g_group/$DPA1
        #sed -i "s|G||g" $output/HLA_DPA1_g_group/$DPA1
        sed -i "s|\;|%DPA1-|g" $output/HLA_DPA1_g_group/$DPA1
        sed -i "s|\/|%DPA1-|g" $output/HLA_DPA1_g_group/$DPA1
        sed -i "s|%|\n|g" $output/HLA_DPA1_g_group/$DPA1
        sed -i '/^\s*$/d' $output/HLA_DPA1_g_group/$DPA1
        rm $output/HLA_DPA1_g_group/hla_DPA1_g_group.txt
        done<$output/HLA_DPA1_g_group/HLA_DPA1_g_group.txt


mkdir -p $output/HLA_DPB1_g_group
grep "^DPB1.*G$" $execlist > $output/HLA_DPB1_g_group/HLA_DPB1_g_group.txt
while read line;
        do
        echo $line > $output/HLA_DPB1_g_group/hla_DPB1_g_group.txt
        DPB1=$(grep "^DPB1.*G$" $output/HLA_DPB1_g_group/hla_DPB1_g_group.txt | awk -F ';' ' {print "DPB1-"$3".txt"}')
        echo $DPB1 >> $output/HLA_DPB1_g_group/HLA_DPB1_g_group_list.txt
        sed -i "s|.txt||g" $output/HLA_DPB1_g_group/HLA_DPB1_g_group_list.txt
        cat $output/HLA_DPB1_g_group/hla_DPB1_g_group.txt > $output/HLA_DPB1_g_group/$DPB1
        sed -i "s|DPB1\*;|DPB1-|g" $output/HLA_DPB1_g_group/$DPB1
        #sed -i "s|G||g" $output/HLA_DPB1_g_group/$DPB1
        sed -i "s|\;|%DPB1-|g" $output/HLA_DPB1_g_group/$DPB1
        sed -i "s|\/|%DPB1-|g" $output/HLA_DPB1_g_group/$DPB1
        sed -i "s|%|\n|g" $output/HLA_DPB1_g_group/$DPB1
        sed -i '/^\s*$/d' $output/HLA_DPB1_g_group/$DPB1
        rm $output/HLA_DPB1_g_group/hla_DPB1_g_group.txt
        done<$output/HLA_DPB1_g_group/HLA_DPB1_g_group.txt


mkdir -p $output/HLA_DQA1_g_group
grep "^DQA1.*G$" $execlist > $output/HLA_DQA1_g_group/HLA_DQA1_g_group.txt
while read line;
        do
        echo $line > $output/HLA_DQA1_g_group/hla_DQA1_g_group.txt
        DQA1=$(grep "^DQA1.*G$" $output/HLA_DQA1_g_group/hla_DQA1_g_group.txt | awk -F ';' ' {print "DQA1-"$3".txt"}')
        echo $DQA1 >> $output/HLA_DQA1_g_group/HLA_DQA1_g_group_list.txt
        sed -i "s|.txt||g" $output/HLA_DQA1_g_group/HLA_DQA1_g_group_list.txt
        cat $output/HLA_DQA1_g_group/hla_DQA1_g_group.txt > $output/HLA_DQA1_g_group/$DQA1
        sed -i "s|DQA1\*;|DQA1-|g" $output/HLA_DQA1_g_group/$DQA1
        #sed -i "s|G||g" $output/HLA_DQA1_g_group/$DQA1
        sed -i "s|\;|%DQA1-|g" $output/HLA_DQA1_g_group/$DQA1
        sed -i "s|\/|%DQA1-|g" $output/HLA_DQA1_g_group/$DQA1
        sed -i "s|%|\n|g" $output/HLA_DQA1_g_group/$DQA1
        sed -i '/^\s*$/d' $output/HLA_DQA1_g_group/$DQA1
        rm $output/HLA_DQA1_g_group/hla_DQA1_g_group.txt
        done<$output/HLA_DQA1_g_group/HLA_DQA1_g_group.txt


mkdir -p $output/HLA_DQB1_g_group
grep "^DQB1.*G$" $execlist > $output/HLA_DQB1_g_group/HLA_DQB1_g_group.txt
while read line;
        do
        echo $line > $output/HLA_DQB1_g_group/hla_DQB1_g_group.txt
        DQB1=$(grep "^DQB1.*G$" $output/HLA_DQB1_g_group/hla_DQB1_g_group.txt | awk -F ';' ' {print "DQB1-"$3".txt"}')
        echo $DQB1 >> $output/HLA_DQB1_g_group/HLA_DQB1_g_group_list.txt
        sed -i "s|.txt||g" $output/HLA_DQB1_g_group/HLA_DQB1_g_group_list.txt
        cat $output/HLA_DQB1_g_group/hla_DQB1_g_group.txt > $output/HLA_DQB1_g_group/$DQB1
        sed -i "s|DQB1\*;|DQB1-|g" $output/HLA_DQB1_g_group/$DQB1
        #sed -i "s|G||g" $output/HLA_DQB1_g_group/$DQB1
        sed -i "s|\;|%DQB1-|g" $output/HLA_DQB1_g_group/$DQB1
        sed -i "s|\/|%DQB1-|g" $output/HLA_DQB1_g_group/$DQB1
        sed -i "s|%|\n|g" $output/HLA_DQB1_g_group/$DQB1
        sed -i '/^\s*$/d' $output/HLA_DQB1_g_group/$DQB1
        rm $output/HLA_DQB1_g_group/hla_DQB1_g_group.txt
        done<$output/HLA_DQB1_g_group/HLA_DQB1_g_group.txt


mkdir -p $output/HLA_DRB1_g_group
grep "^DRB1.*G$" $execlist > $output/HLA_DRB1_g_group/HLA_DRB1_g_group.txt
while read line;
        do
        echo $line > $output/HLA_DRB1_g_group/hla_DRB1_g_group.txt
        DRB1=$(grep "^DRB1.*G$" $output/HLA_DRB1_g_group/hla_DRB1_g_group.txt | awk -F ';' ' {print "DRB1-"$3".txt"}')
        echo $DRB1 >> $output/HLA_DRB1_g_group/HLA_DRB1_g_group_list.txt
        sed -i "s|.txt||g" $output/HLA_DRB1_g_group/HLA_DRB1_g_group_list.txt
        cat $output/HLA_DRB1_g_group/hla_DRB1_g_group.txt > $output/HLA_DRB1_g_group/$DRB1
        sed -i "s|DRB1\*;|DRB1-|g" $output/HLA_DRB1_g_group/$DRB1
        #sed -i "s|G||g" $output/HLA_DRB1_g_group/$DRB1
        sed -i "s|\;|%DRB1-|g" $output/HLA_DRB1_g_group/$DRB1
        sed -i "s|\/|%DRB1-|g" $output/HLA_DRB1_g_group/$DRB1
        sed -i "s|%|\n|g" $output/HLA_DRB1_g_group/$DRB1
        sed -i '/^\s*$/d' $output/HLA_DRB1_g_group/$DRB1
        rm $output/HLA_DRB1_g_group/hla_DRB1_g_group.txt
        done<$output/HLA_DRB1_g_group/HLA_DRB1_g_group.txt


cp -Rp $output $(cd `dirname $0`; cd .. ; pwd)/Lists/HLA_g_group_org
while read gene;
        do
        while read line;
                do
                sed -i 's/\(.*\)/\1:/g'  $output/"HLA_"$gene"_g_group"/$line".txt"
                done<$output/"HLA_"$gene"_g_group"/"HLA_"$gene"_g_group_list.txt"
        done<$genelist

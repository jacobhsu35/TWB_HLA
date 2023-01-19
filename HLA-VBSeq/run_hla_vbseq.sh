#!/usr/bin/bash
# SLURM job script (please modify or remove if not)
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J AA024_V_wgs_sentieon         # Job name # please modify 'AA024'
#SBATCH -p ngs92G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14               # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_hlavbseq_hla.out          # Path to the standard output file # please modify '/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX' and 'AA024'
#SBATCH -e /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_hlavbseq_hla.err          # Path to the standard error ouput file # please modify '/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX' and 'AA024'
#SBATCH --mail-user=@g.ntu.edu.tw    # email # please modify
#SBATCH --mail-type=END

# Tool path (please modify)
BWA_PATH=/staging/reserve/paylong_ntu/AI_SHARE/software/BWA/Bwa_v0.7.17
SAMTOOLS_PATH=/staging/reserve/paylong_ntu/AI_SHARE/software/Samtools/Samtools_v1.13
VB_SEQ_PATH=/staging/reserve/paylong_ntu/AI_SHARE/software/HLA-VBSeq_v2/VBSeq
VB_SEQ=${VB_SEQ_PATH}/HLAVBSeq.jar
BAM_NAME_INDEX=${VB_SEQ_PATH}/bamNameIndex.jar
PICARD=/staging/reserve/paylong_ntu/AI_SHARE/software/Picard/Picard_v2.25.7/picard.jar
HLA_FASTA=${VB_SEQ_PATH}/hla_all_v2.fasta

# Environment variable (please modify or remove if not)
module load pkg/Anaconda3
module load compiler/gcc/10.2.0
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH

# Input/Output path, Mean single read length, Paired_read_length (please modify)
sample_group=HLA_wgs
data_type=WGS
preprocess_tool=Sentieon # Write None if not
tool=hlavbseq 
output_path=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/${sample_group}/${data_type}_${tool}/${preprocess_tool}_${tool}/${sample_name}/Outputs
input_bam=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/Immune/Immune_20220818_test/Panel_hlavbseq/Sentieon_hlavbseq/AA024/Outputs/Data_preprocessing/AA024_Hs37d5.extracted.recaled.bam
mean_single_read_length=150
paired_read_length=300


#DIR="$( cd "$( dirname "$0" )" && pwd )"

mkdir -p $output_path
cd $output_path

# chromosomes in hg38 are represented as chr<num>
# chromosomes in hg19 is represented as <num>

# Extract a list of read name that were aligned to HLA loci (HLA-A, B, C, DM, DO, DP, DQ, DR, E, F, G, H, J, K, L, P, V, MIC, and TAP)
# ${SAMTOOLS_PATH}/samtools view $input_bam chr6:29907037-29915661 chr6:31319649-31326989 chr6:31234526-31241863 \
# chr6:32914391-32922899 chr6:32900406-32910847 chr6:32969960-32979389 chr6:32778540-32786825 \
# chr6:33030346-33050555 chr6:33041703-33059473 chr6:32603183-32613429 chr6:32707163-32716664 \
# chr6:32625241-32636466 chr6:32721875-32733330 chr6:32405619-32414826 chr6:32544547-32559613 \
# chr6:32518778-32554154 chr6:32483154-32559613 chr6:30455183-30463982 chr6:29689117-29699106 \
# chr6:29792756-29800899 chr6:29793613-29978954 chr6:29855105-29979733 chr6:29892236-29899009 \
# chr6:30225339-30236728 chr6:31369356-31385092 chr6:31460658-31480901 chr6:29766192-29772202 \
# chr6:32810986-32823755 chr6:32779544-32808599 chr6:29756731-29767588 \
# | awk '{print $1}' | sort | uniq > ${output_path}/partial_reads.txt

${SAMTOOLS_PATH}/samtools view $input_bam 6:29907037-29915661 6:31319649-31326989 6:31234526-31241863 \
6:32914391-32922899 6:32900406-32910847 6:32969960-32979389 6:32778540-32786825 \
6:33030346-33050555 6:33041703-33059473 6:32603183-32613429 6:32707163-32716664 \
6:32625241-32636466 6:32721875-32733330 6:32405619-32414826 6:32544547-32559613 \
6:32518778-32554154 6:32483154-32559613 6:30455183-30463982 6:29689117-29699106 \
6:29792756-29800899 6:29793613-29978954 6:29855105-29979733 6:29892236-29899009 \
6:30225339-30236728 6:31369356-31385092 6:31460658-31480901 6:29766192-29772202 \
6:32810986-32823755 6:32779544-32808599 6:29756731-29767588 \
| awk '{print $1}' | sort | uniq > ${output_path}/partial_reads.txt


# Build read name index and search read pairs and their sequences on HLA loci
java -jar $BAM_NAME_INDEX index $input_bam 
java -jar $BAM_NAME_INDEX search $input_bam --name ${output_path}/partial_reads.txt --output ${output_path}/partial.sam
java -jar $PICARD SamToFastq -I ${output_path}/partial.sam -F ${output_path}/partial_1.fastq -F2 ${output_path}/partial_2.fastq

# Extract unmapped reads
${SAMTOOLS_PATH}/samtools view -bh -f 12 $input_bam > ${output_path}/unmapped.bam
java -jar $PICARD SamToFastq -I ${output_path}/unmapped.bam -F ${output_path}/unmapped_1.fastq -F2 ${output_path}/unmapped_2.fastq

# Combine reads in FASTQ format
cat ${output_path}/partial_1.fastq ${output_path}/unmapped_1.fastq > ${output_path}/part_1.fastq
cat ${output_path}/partial_2.fastq ${output_path}/unmapped_2.fastq > ${output_path}/part_2.fastq

# Alignment by BWA-MEM allowing multiple alignments for each read
${BWA_PATH}/bwa mem -t 40 -P -L 10000 -a $HLA_FASTA ${output_path}/part_1.fastq ${output_path}/part_2.fastq > ${output_path}/part.sam

java -jar $VB_SEQ $HLA_FASTA ${output_path}/part.sam ${output_path}/result.txt --alpha_zero 0.01 --is_paired

# Calculates the average depth of coverage for each HLA allele
cp ${output_path}/result.txt ${output_path}/allele_info.txt
modfile=${output_path}/allele_info.txt
alleleinfo=/staging/reserve/paylong_ntu/AI_SHARE/software/HLA-VBSeq_v2/VBSeq/allele_v3310.txt
alleleid=/staging/reserve/paylong_ntu/AI_SHARE/software/HLA-VBSeq_v2/VBSeq/allele_ID_v3310.txt

while IFS= read -r -u 4 line1 && IFS= read -r -u 5 line2;
        do
        cd ./ &&
        sed -i "s|HLA\:$line1|$line2|g" $modfile
        done 4<$alleleid 5<$alleleinfo

cat $modfile |grep -v ^ID |awk  -v paired_read_length=$paired_read_length -F ' ' ' {print $1" "paired_read_length*$3/$2}' |sort -n -k 2 -r > ${output_path}/HLA_read_depth.txt

grep "^A\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_A_read_depth.txt
grep "^B\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_B_read_depth.txt
grep "^C\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_C_read_depth.txt
grep "^DPA1\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DPA1_read_depth.txt
grep "^DPB1\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DPB1_read_depth.txt
grep "^DQA1\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DQA1_read_depth.txt
grep "^DQB1\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DQB1_read_depth.txt
grep "^DRB1\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DRB1_read_depth.txt
grep "^DRB3\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DRB3_read_depth.txt
grep "^DRB4\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DRB4_read_depth.txt
grep "^DRB5\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_DRB5_read_depth.txt
grep "^G\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_G_read_depth.txt
grep "^V\*" ${output_path}/HLA_read_depth.txt |sort -k2 -n -r > ${output_path}/HLA_V_read_depth.txt

# HLA Call
python3 ${VB_SEQ_PATH}/call_hla_digits.py -v ${output_path}/result.txt -a ${VB_SEQ_PATH}/Allelelist_v2.txt -r $mean_single_read_length -d 4 --ispaired > ${output_path}/report.d4.txt
python3 ${VB_SEQ_PATH}/call_hla_digits.py -v ${output_path}/result.txt -a ${VB_SEQ_PATH}/Allelelist_v2.txt -r $mean_single_read_length -d 6 --ispaired > ${output_path}/report.d6.txt
python3 ${VB_SEQ_PATH}/call_hla_digits.py -v ${output_path}/result.txt -a ${VB_SEQ_PATH}/Allelelist_v2.txt -r $mean_single_read_length -d 8 --ispaired > ${output_path}/report.d8.txt

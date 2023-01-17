#!/usr/bin/bash
# SLURM job script (please modify or remove if not)
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J AA024_H_wgs_sentieon         # Job name
#SBATCH -p ngs92G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14               # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_hisatgenotype_hla.out          # Path to the standard output file
#SBATCH -e /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_hisatgenotype_hla.err          # Path to the standard error ouput file
#SBATCH --mail-user=r09455002@g.ntu.edu.tw    # email
#SBATCH --mail-type=END

# Tool path (please modify)
SAMTOOLS_PATH=/staging/reserve/paylong_ntu/AI_SHARE/software/Samtools/Samtools_v1.13
export PATH=/staging/reserve/paylong_ntu/AI_SHARE/software/HISAT2/Hisat2_v2.2.1/hisatgenotype:/staging/reserve/paylong_ntu/AI_SHARE/software/HISAT2/Hisat2_v2.2.1/hisatgenotype/hisat2:$PATH
export PYTHONPATH=/staging/reserve/paylong_ntu/AI_SHARE/software/HISAT2/Hisat2_v2.2.1/hisatgenotype/hisatgenotype_modules:$PYTHONPATH

# Environment variable (please modify or remove if not)
module load pkg/Anaconda3 
module load compiler/gcc/10.2.0
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH

# Input/Output path, sample name, hisat index path (please modify)
input_bam=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/Immune/Immune_20220818_test/Panel_hisatgenotype/Sentieon_hisatgenotype/AA024/Outputs/Data_preprocessing/AA024_Hs38DH.extracted.recaled.bam
sample_name=AA024
sample_group=HLA_wgs
data_type=WGS
preprocess_tool=Sentieon # Write None if not
tool=hisatgenotype
sh_path=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/Release_version/HLA_pipeline/HISAT-genotype
org_index_path=/staging/reserve/paylong_ntu/AI_SHARE/software/HISAT2/Hisat2_v2.2.1/hisat_index
output_path=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/${sample_group}/${data_type}_${tool}/${preprocess_tool}_${tool}/${sample_name}/Outputs
data_preprocessing_path=${output_path}/Data_preprocessing
mkdir -p $output_path
mkdir -p $data_preprocessing_path

# 14 for ngs48G queue, 28 for ngs96G queue
NUM_THREAD=14

cd $output_path

# ***********************************
# Run Hisat2 and Hisat-genotype
# ***********************************
${SAMTOOLS_PATH}/samtools sort -@$NUM_THREAD $input_bam -o ${data_preprocessing_path}/${sample_name}_hs38DH.extracted.recaled.sorted.bam -n
${SAMTOOLS_PATH}/samtools fastq -N -0 /dev/null -s ${data_preprocessing_path}/${sample_name}_hs38DH_extracted_s.fq.gz -1 ${data_preprocessing_path}/${sample_name}_hs38DH_extracted_1.fq.gz -2 ${data_preprocessing_path}/${sample_name}_hs38DH_extracted_2.fq.gz ${data_preprocessing_path}/${sample_name}_hs38DH.extracted.recaled.sorted.bam

### Delete bam file
rm ${data_preprocessing_path}/${sample_name}_hs38DH.extracted.recaled.sorted.bam

index_dir=hisatindex_${sample_name}
mkdir -p ${sh_path}/Index/${data_type}/${preprocess_tool}
cp -Rp ${org_index_path} ${sh_path}/Index/${data_type}/${preprocess_tool}/${index_dir}
index_path="${sh_path}/Index/${data_type}/${preprocess_tool}/${index_dir}"

hisatgenotype --base hla \
              --threads 14 \
              --keep-alignment -v --keep-extract \
              -z $index_path \
              -1 Data_preprocessing/${sample_name}_hs38DH_extracted_1.fq.gz \
              -2 Data_preprocessing/${sample_name}_hs38DH_extracted_2.fq.gz \
              --out-dir ./

# rename file
mv *fq.report ${sample_name}_hla.report
mv *fq.bam ${sample_name}_hla_extracted.bam
mv *fq.bam.bai ${sample_name}_hla_extracted.bam.bai
mv *-hla-extracted-1.fq.gz ${sample_name}_hla_extracted_1.fq.gz
mv *-hla-extracted-2.fq.gz ${sample_name}_hla_extracted_2.fq.gz

rm -rf $index_path

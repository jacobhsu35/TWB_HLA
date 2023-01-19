#!/usr/bin/bash
# SLURM job script (please modify or remove if not)
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J AA024_L_wgs_sentieon         # Job name # please modify 'AA024'
#SBATCH -p ngs92G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14               # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_hlala_hla.out          # Path to the standard output file # please modify '/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX' and 'AA024'
#SBATCH -e /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_hlala_hla.err          # Path to the standard error ouput file # please modify '/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX' and 'AA024'
#SBATCH --mail-user=@g.ntu.edu.tw    # email # please modify
#SBATCH --mail-type=END

# Tool path (please modify)
HLA_LA_PATH=/staging/biology/u8802208/HLA-LA_v1.0.3/bin
REF_PATH=/staging/reserve/paylong_ntu/AI_SHARE/reference
REF=${REF_PATH}/HLA_Ref/bwa.kit/hs38DH.fa
module load biology/HLA-LA
module load biology/Samtools
module load biology/BWA
module load biology/Picard

# Environment variable (please modify or remove if not)
module load compiler/gcc/10.4.0
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH

# Input/Output path, Sample name (please modify)
input_bam=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/Immune/Immune_20220818_test/Panel_hisatgenotype/Sentieon_hisatgenotype/AA024/Outputs/Data_preprocessing/AA024_Hs38DH.extracted.recaled.bam
sample_name=AA024
sample_group=HLA_wgs
data_type=WGS
preprocess_tool=Sentieon # Write None if not
tool=hlala
output_path=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/${sample_group}/${data_type}_${tool}/${preprocess_tool}_${tool}/${sample_name}
mkdir -p $output_path

${HLA_LA_PATH}/HLA-LA.pl --BAM $input_bam --graph PRG_MHC_GRCh38_withIMGT --sampleID $sample_name --workingDir $output_path --maxThreads 14

mv ${output_path}/${sample_name} ${output_path}/Outputs

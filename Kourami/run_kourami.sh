#!/usr/bin/bash
# SLURM job script (please modify or remove if not)
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J AA024_K_wgs_sentieon         # Job name
#SBATCH -p ngs92G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14               # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_kourami_hla.out          # Path to the standard output file
#SBATCH -e /staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/HLA_wgs/Err_msg/AA024_wgs_sentieon_kourami_hla.err          # Path to the standard error ouput file
#SBATCH --mail-user=r09455002@g.ntu.edu.tw    # email
#SBATCH --mail-type=END

# Tool path (please modify)
BAMUTIL_PATH=/opt/ohpc/Taiwania3/pkg/biology/bamUtil/bamUtil_v1.0.15/bin
KOURAMI="/staging/reserve/paylong_ntu/AI_SHARE/software/Kourami/Kourami_v0.9.6_HLA_v3450/build/Kourami.jar"
DATABASE_PATH="/staging/reserve/paylong_ntu/AI_SHARE/software/Kourami/Kourami_v0.9.6_HLA_v3450/custom_db/IMGTHLA_v3.45.0"
SCRIPT_PATH="/staging/reserve/paylong_ntu/AI_SHARE/software/Kourami/Kourami_v0.9.6_HLA_v3450/scripts"
REF_PATH=/staging/reserve/paylong_ntu/AI_SHARE/reference/HLA_Ref/bwa.kit
REF=${REF_PATH}/hs38DH.fa

# Environment variable (please modify or remove if not)
module load compiler/gcc/10.2.0
export LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH
export PATH=$BAMUTIL_PATH:$PATH

# Input/Output path, Sample name (please modify)
input_bam=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/Immune/Immune_20220818_test/Panel_hisatgenotype/Sentieon_hisatgenotype/AA024/Outputs/Data_preprocessing/AA024_Hs38DH.extracted.recaled.bam
sample_name=AA024
sample_group=HLA_wgs
data_type=WGS
preprocess_tool=Sentieon # Write None if not
tool=kourami
output_path=/staging/reserve/paylong_ntu/AI_SHARE/temp/HLA_temp/YX/${sample_group}/${data_type}_${tool}/${preprocess_tool}_${tool}/${sample_name}/Outputs

mkdir -p $output_path
cd $output_path
current_script_path=$(pwd)

${SCRIPT_PATH}/alignAndExtract_hs38DH.sh -d $DATABASE_PATH -r $REF sample $input_bam > ${output_path}/align_and_extract.log 2>&1

# move intermediate work file to correct location
mv ${current_script_path}/sample_on_KouramiPanel.bam ${output_path}/sample_on_KouramiPanel.bam

java -Xmx46g -jar $KOURAMI -d $DATABASE_PATH -o ${output_path}/sample ${output_path}/sample_on_KouramiPanel.bam -a > ${output_path}/kourami.log 2>&1

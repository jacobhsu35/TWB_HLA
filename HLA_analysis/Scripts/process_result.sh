#!/usr/bin/bash
workdir=$(cd `dirname $0`; pwd)
data_type=$1
preprocess_tool=$2
tool=$3
ngsid=$4
hlaid=$5
sample_number=$6
outputdir=$7

if [ ! -d "${outputdir}/${data_type}_twb/${preprocess_tool}_twb/${ngsid}/Results" ] && [[ $tool = 'twb' ]] 
then    
	bash ${workdir}/twb_result.sh $data_type $preprocess_tool $ngsid $hlaid $outputdir
	bash ${workdir}/result_d4.sh $data_type $preprocess_tool twb $ngsid $outputdir
	bash ${workdir}/result_d6.sh $data_type $preprocess_tool twb $ngsid $outputdir 
	bash ${workdir}/result_d8.sh $data_type $preprocess_tool twb $ngsid $outputdir
	bash ${workdir}/result_Gg.sh $data_type $preprocess_tool twb $ngsid $sample_number $outputdir
	bash ${workdir}/result_Gg_org.sh $data_type $preprocess_tool twb $ngsid $sample_number $outputdir

elif [ ! -d "${outputdir}/${data_type}_hlavbseq/${preprocess_tool}_hlavbseq/${ngsid}/Results" ] && [[ $tool = 'hlavbseq' ]]
then
	bash ${workdir}/hlavbseq_result.sh $data_type $preprocess_tool $ngsid d4 $outputdir
	bash ${workdir}/hlavbseq_result.sh $data_type $preprocess_tool $ngsid d6 $outputdir
	bash ${workdir}/hlavbseq_result.sh $data_type $preprocess_tool $ngsid d8 $outputdir
	bash ${workdir}/result_Gg.sh $data_type $preprocess_tool hlavbseq $ngsid $sample_number $outputdir
	bash ${workdir}/result_Gg_org.sh $data_type $preprocess_tool hlavbseq $ngsid $sample_number $outputdir

elif [ ! -d "${outputdir}/${data_type}_kourami/${preprocess_tool}_kourami/${ngsid}/Results" ] && [[ $tool = 'kourami' ]]
then
	bash ${workdir}/kourami_result.sh $data_type $preprocess_tool $ngsid $outputdir

elif [ ! -d "${outputdir}/${data_type}_hisatgenotype/${preprocess_tool}_hisatgenotype/${ngsid}/Results" ] && [[ $tool = 'hisatgenotype' ]]
then
	bash ${workdir}/hisatgenotype_result.sh $data_type $preprocess_tool $ngsid $outputdir
	bash ${workdir}/result_d4.sh $data_type $preprocess_tool hisatgenotype $ngsid $outputdir
	bash ${workdir}/result_d6.sh $data_type $preprocess_tool hisatgenotype $ngsid $outputdir
	bash ${workdir}/result_d8.sh $data_type $preprocess_tool hisatgenotype $ngsid $outputdir
	bash ${workdir}/result_Gg.sh $data_type $preprocess_tool hisatgenotype $ngsid $sample_number $outputdir
	bash ${workdir}/result_Gg_org.sh $data_type $preprocess_tool hisatgenotype $ngsid $sample_number $outputdir

elif [ ! -d "${outputdir}/${data_type}_hlala/${preprocess_tool}_hlala/${ngsid}/Results" ] && [[ $tool = 'hlala' ]]
then
        bash ${workdir}/hlala_result.sh $data_type $preprocess_tool $ngsid $outputdir
fi


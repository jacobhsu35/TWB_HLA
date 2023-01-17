#!/usr/bin/bash
workdir=$(cd `dirname $0`; pwd)
data_type_1=$1
data_type_2=$2
preprocess_tool_1=$3
preprocess_tool_2=$4
tool_1=$5
tool_2=$6
ngsid=$7
hlaid=$8
sample_number=$9
outputdir=${10}

bash ${workdir}/process_result.sh $data_type_1 $preprocess_tool_1 $tool_1 $ngsid $hlaid $sample_number $outputdir
bash ${workdir}/process_result.sh $data_type_2 $preprocess_tool_2 $tool_2 $ngsid $hlaid $sample_number $outputdir

if [[ $tool_1 != 'kourami' ]] && [[ $tool_2 != 'kourami' ]] && [[ $tool_1 != 'hlala' ]] && [[ $tool_2 != 'hlala' ]]
then
	bash ${workdir}/compare_d4.sh $data_type_1 $data_type_2 $preprocess_tool_1 $preprocess_tool_2 $tool_1 $tool_2 $ngsid $outputdir
	bash ${workdir}/compare_d6.sh $data_type_1 $data_type_2 $preprocess_tool_1 $preprocess_tool_2 $tool_1 $tool_2 $ngsid $outputdir
	bash ${workdir}/compare_d8.sh $data_type_1 $data_type_2 $preprocess_tool_1 $preprocess_tool_2 $tool_1 $tool_2 $ngsid $outputdir
fi

bash ${workdir}/compare_Gg.sh $data_type_1 $data_type_2 $preprocess_tool_1 $preprocess_tool_2 $tool_1 $tool_2 $ngsid $outputdir

if [[ $tool_1 != 'kourami' ]] && [[ $tool_2 != 'kourami' ]] && [[ $tool_1 != 'hlala' ]] && [[ $tool_2 != 'hlala' ]]
then
	bash ${workdir}/count_pm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid d4 $sample_number $outputdir
	bash ${workdir}/count_pm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid d6 $sample_number $outputdir
	bash ${workdir}/count_pm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid d8 $sample_number $outputdir
fi

bash ${workdir}/count_pm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid Gg $sample_number $outputdir

if [[ $tool_1 != 'kourami' ]] && [[ $tool_2 != 'kourami' ]] && [[ $tool_1 != 'hlala' ]] && [[ $tool_2 != 'hlala' ]]
then
	bash ${workdir}/count_npm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid d4 $sample_number $outputdir
	bash ${workdir}/count_npm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid d6 $sample_number $outputdir
	bash ${workdir}/count_npm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid d8 $sample_number $outputdir
fi

bash ${workdir}/count_npm.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 $ngsid Gg $sample_number $outputdir

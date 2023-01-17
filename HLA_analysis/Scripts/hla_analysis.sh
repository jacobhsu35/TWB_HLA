#!/usr/bin/bash
workdir=$(cd `dirname $0`; pwd)
data_type_1=$1
data_type_2=$2
preprocess_tool_1=$3
preprocess_tool_2=$4
tool_1=$5
tool_2=$6
sample_number=$7
outputdir=$8
WGS_SAMPLE=$(cd `dirname $0`; cd .. ; pwd)/Lists/${9}.txt
HLA_SAMPLE=$(cd `dirname $0`; cd .. ; pwd)/Lists/${10}.txt

while IFS= read -r -u 4 ngsid && IFS= read -r -u 5 hlaid;
	do
		bash ${workdir}/analysis_process.sh $data_type_1 $data_type_2 $preprocess_tool_1 $preprocess_tool_2 $tool_1 $tool_2 $ngsid $hlaid $sample_number $outputdir
	done 4<$WGS_SAMPLE 5<$HLA_SAMPLE


if [[ $tool_1 != 'kourami' ]] && [[ $tool_2 != 'kourami' ]] && [[ $tool_1 != 'hlala' ]] && [[ $tool_2 != 'hlala' ]]
then
	bash ${workdir}/sensitivity.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 d4 $sample_number $outputdir
	bash ${workdir}/sensitivity.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 d6 $sample_number $outputdir
	bash ${workdir}/sensitivity.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 d8 $sample_number $outputdir
fi

bash ${workdir}/sensitivity.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 Gg $sample_number $outputdir

if [[ $tool_1 != 'kourami' ]] && [[ $tool_2 != 'kourami' ]] && [[ $tool_1 != 'hlala' ]] && [[ $tool_2 != 'hlala' ]]
then
        bash ${workdir}/accuracy.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 d4 $sample_number $outputdir
        bash ${workdir}/accuracy.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 d6 $sample_number $outputdir
        bash ${workdir}/accuracy.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 d8 $sample_number $outputdir
fi

bash ${workdir}/accuracy.sh $data_type_1 $preprocess_tool_1 $tool_1 $tool_2 Gg $sample_number $outputdir


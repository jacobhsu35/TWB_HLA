#!/usr/bin/bash
workdir=$(cd `dirname $0`; pwd)
data_type=${1}
preprocess_tool=${2}
tool=${3}
sample_number=${4}
outputdir=${5}
WGS_SAMPLE=$(cd `dirname $0`; cd .. ; pwd)/Lists/${6}.txt

while IFS= read -r -u 4 ngsid;
	do
		bash ${workdir}/process_result.sh $data_type $preprocess_tool $tool $ngsid None $sample_number $outputdir
	done 4<$WGS_SAMPLE



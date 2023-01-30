## WGS HLA pipeline
#### Software dependencies
The HLA pipeline includes [HISAT2](https://daehwankimlab.github.io/hisat2/)/[HISAT-genotype](https://daehwankimlab.github.io/hisat-genotype/), [HLA-VBSeq](http://nagasakilab.csml.org/hla/), [Kourami](https://github.com/Kingsford-Group/kourami), and [HLA\*LA](https://github.com/DiltheyLab/HLA-LA)

#### Generate human reference genome
- Download [bwakit v0.7.15](https://sourceforge.net/projects/bio-bwa/files/bwakit/bwakit-0.7.15_x64-linux.tar.bz2/download)

- Modify the bash file (bwa.kit/run-gen-ref) in bwakit v0.7.15 folder

  ```bash
  url38="http://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_full_analysis_set.fna.gz"
  url37d5="http://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/technical/reference/phase2_reference_assembly_sequence/hs37d5.fa.gz"
  ```

- Produce hs37d5.fa

  ```bash
  cd bwa.kit
  bash run-gen-ref hs37d5
  ```

- Produce hs38DH.fa
  ```bash
  cd bwa.kit
  bash run-gen-ref hs38DH
  ```

#### Software version/setup

For the HISAT2 and HISAT-genotype:
- Install [HISAT2 v2.2.1](https://cloud.biohpc.swmed.edu/index.php/s/oTtGWbWjaxsQ2Ho/download) (Linux_x86_64), [samtools v1.13 or better](https://sourceforge.net/projects/samtools/files/samtools/), [Python3](https://www.python.org/downloads/)

- Setup HISAT-genotype v1.3.2

  ```bash
  cd hisat2-2.2.1
  git clone https://github.com/DaehwanKimLab/hisat-genotype.git ./hisatgenotype
  echo '{"sanity_check": false}' > hisatgenotype/devel/settings.json
  ```

- Download genome

  ```bash
  cd hisat2-2.2.1
  mkdir hisat_index
  cd hisat_index
  wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat-genotype/data/genotype_genome_20180128.tar.gz
  tar xvzf genotype_genome_20180128.tar.gz

  wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/data/grch38.tar.gz
  tar xvzf grch38.tar.gz
  rm grch38.tar.gz
  hisat2-inspect grch38/genome > genome.fa
  samtools faidx genome.fa
  cd ..
  ```

- Input file -- `BAM file` based on human reference genome `hs38DH`

For the HLA-VBSeq:

- Install  [Picard_v2.25.7 or better](https://github.com/broadinstitute/picard/releases), [Python3](https://www.python.org/downloads/)

- Download [HLAVBSeq.jar](http://nagasakilab.csml.org/hla/HLAVBSeq.jar), [bamNameIndex.jar](http://nagasakilab.csml.org/hla/bamNameIndex.jar), [SamToFastq.jar](http://sourceforge.net/projects/picard/files/latest/download), [parse_result.pl](http://nagasakilab.csml.org/hla/parse_result.pl) and [call_hla_digits.py](http://nagasakilab.csml.org/hla/call_hla_digits.py)

- Use HLA v2 database based on IMGT/HLA database Release 3.31.0 and Japanese HLA reference dataset ([Mimori et al Pharmacogenomics J. 2018](https://www.ncbi.nlm.nih.gov/pubmed/29352165)) : [hla_all_v2.fasta](http://nagasakilab.csml.org/hla/hla_all_v2.fasta) and [Allelelist_v2.txt](http://nagasakilab.csml.org/hla/Allelelist_v2.txt)

- Input file -- `BAM file` based on human reference genome `hs37d5`

For the Kourami:

- Install  [Kourami_v0.9.6](https://github.com/Kingsford-Group/kourami/releases/tag/v0.9.6), [bamUtil_v1.0.15](https://github.com/statgen/bamUtil/releases)

-  Creating Kourami HLA panel and merged MSAs from another version (release) of IMGT/HLA DB or a custom version --- [Tutorial](https://github.com/Kingsford-Group/kourami/blob/master/preprocessing.md#2-creating-kourami-hla-panel-and-merged-msas-from-another-version-release-of-imgthla-db-or-a-custom-version)

  - Download `IMGT/HLA DB v3450` and `hla_nom_g.txt` from the same release of IMGT/HLA

    ```bash
    cd kourami-0.9.6
    wget https://github.com/ANHIG/IMGTHLA/raw/3450/Alignments_Rel_3450.zip
    unzip Alignments_Rel_3450.zip
    wget https://github.com/ANHIG/IMGTHLA/raw/3450/wmda/hla_nom_g.txt
    mv hla_nom_g.txt alignments
    ```

  - Modify the txt file (alignments/Y_gen.txt) in kourami-0.9.6 folder

    ```bash
    gDNA              0
                      |
    Y*01:01           | ATGGCGGTC
    Y*02:01           | ---------
    Y*03:01           | ---------
    ```

  - Modify the bash file (scripts/formatIMGT.sh) in kourami-0.9.6 folder

    ```bash
    #else
    #    cp $resource_dir/DRB5_gen.txt $input_msa/.
    ```

  - Create new version HLA reference  (IMGT/HLA DB v3450)

    ```bash
    cd kourami-0.9.6
    bash scripts/formatIMGT.sh -i alignments -v IMGTHLA_v3.45.0 -o custom_db
    ```

- Use human reference genome `hs38DH`

- Input file -- `BAM file` based on human reference genome `hs38DH`

For the HLA-LA:

- Install [HLA-LA](https://github.com/DiltheyLab/HLA-LA)

> IF manual installation, the prerequisites are as follows:
>
> g++ with support for C++11 (e.g. 4.7.2)
>
> Boost >= 1.59, Bamtools, libz, bwa >= 0.7.12, samtools >= 1.3, picard

- Input file -- `BAM file` based on human reference genome `hs38DH`


#### Running pipeline

#### Use case 1 (input with bam [base on hs37d5] )

1. Suggest to use for HLA-VBSeq

2. Modify bash file in HLA-VBSeq folder
[`run_hla_vbseq.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/HLA-VBSeq/run_hla_vbseq.sh)

   - Modifications include:

     - Mean single read length
     - Paired read length
     - Tool path
     - Input/Output path
       > [Optional] The output path must be the same as the following to use subsequent HLA genotype comparison and labeling
        ```bash
        sample_group=HLA_wgs
        data_type=WGS
        preprocess_tool=Sentieon # Write None if not
        tool=hlavbseq

       output_path=/${sample_group}/${data_type}_${tool}/${preprocess_tool}_${tool}/${sample_name}/Outputs
        ```


3. Please execute:

     `sbatch(or bash) run_hla_vbseq.sh`

4. HLA genotyping results:
    -    HLA-VBSeq:
    [`report.d4.txt`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_hlavbseq/Sentieon_hlavbseq/NGS2_20150303E/Outputs/report.d4.txt) (2-field resolution)
    [`report.d6.txt`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_hlavbseq/Sentieon_hlavbseq/NGS2_20150303E/Outputs/report.d6.txt) (3-field resolution)
    [`report.d8.txt`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_hlavbseq/Sentieon_hlavbseq/NGS2_20150303E/Outputs/report.d8.txt) (4-field resolution)

#### Use case 2 (input with bam [base on hs38DH] )

1. Suggest to use for HISAT-genotype/Kourami/HLA*LA
2. Modify bash file in HISAT-genotype/Kourami/HLA*LA folder
    [`run_hisat_genotype.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/HISAT-genotype/run_hisat_genotype.sh)/
    [`run_kourami.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/Kourami/run_kourami.sh)/
    [`run_hla_la.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/HLA-LA/run_hla_la.sh)

   - Modifications include:

     - Sample name
     - Tool path
     - Hisat index path (only required for HISAT-genotype)
     - Input/Output path
       > [Optional] The output path must be the same as the following to use subsequent HLA genotype comparison and labeling
        ```bash
        sample_group=HLA_wgs
        data_type=WGS
        preprocess_tool=Sentieon # Write None if not
        tool=hisatgenotype # or kourami

       output_path=/${sample_group}/${data_type}_${tool}/${preprocess_tool}_${tool}/${sample_name}/Outputs
        ```
        ```bash
        sample_group=HLA_wgs
        data_type=WGS
        preprocess_tool=Sentieon # Write None if not
        tool=hlala

       output_path=/${sample_group}/${data_type}_${tool}/${preprocess_tool}_${tool}/${sample_name}
        ```

3. Please execute:
    `sbatch(or bash) run_hisat_genotype.sh`/
    `sbatch(or bash) run_kourami.sh`/
    `sbatch(or bash) run_hla_la.sh`
4. HLA genotyping results:
    -    HISAT-genotype (up to 4-field resolution):
    [`[sample_name]_hla.report`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_hisatgenotype/Sentieon_hisatgenotype/NGS2_20150303E/Outputs/NGS2_20150303E_hla.report)
    -    Kourami (g group resolution):
    [`sample.result`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_kourami/Sentieon_kourami/NGS2_20150303E/Outputs/sample.result)
    -    HLA*LA (g group resolution):
    [`R1_bestguess_G.txt`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_hlala/Sentieon_hlala/NGS2_20150303E/Outputs/hla/R1_bestguess_G.txt)

#### HLA genotype comparison (depend on Linux)
![](https://i.imgur.com/2gvhwSe.png)
1. Create reference answer
  > The file structure and name must be the same as the following, except for the sample name.
  [`HLA_wgs/[data_type]_reference/[preprocess_tool(or None)]_reference/[sample_name]/Results`](https://github.com/yixuan-429/TWB_HLA/tree/main/Test/Analyzed_data/HLA_wgs/WGS_reference/None_reference/NGS2_20150303E/Results)
> * Results folder must have 4 files:
  (If there are only results with a specific resolution, you can put the results in the file with a specific resolution, and other files can be blank)
    -   G group(Gg)/2-field(d4)/3-field(d6)/4-field(d8)
  > 1. [[sample_name]_reference_result_Gg.txt](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_reference/None_reference/NGS2_20150303E/Results/NGS2_20150303E_reference_result_Gg.txt)
  > 2. [[sample_name]_reference_result_d4.txt](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_reference/None_reference/NGS2_20150303E/Results/NGS2_20150303E_reference_result_d4.txt)
  > 3. [[sample_name]_reference_result_d6.txt](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_reference/None_reference/NGS2_20150303E/Results/NGS2_20150303E_reference_result_d6.txt)
  > 4. [[sample_name]_reference_result_d8.txt](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_data/HLA_wgs/WGS_reference/None_reference/NGS2_20150303E/Results/NGS2_20150303E_reference_result_d8.txt)

2. Create sample list in HLA_analysis/Lists folder
    [`sample_list.txt`](https://github.com/yixuan-429/TWB_HLA/blob/main/HLA_analysis/Lists/sample_list.txt)

3. [Optional] Create new g group comparison table, the default version of g group list is IPD-IMGT/HLA 3.45.0, the lastest version can be download from [here](http://hla.alleles.org/wmda/hla_nom_g.txt), the creation method  as follows
- Add g group list with new version and remove default g group comparison table in HLA_analysis/Lists folder
    ```bash
    wget https://raw.githubusercontent.com/ANHIG/IMGTHLA/Latest/wmda/hla_nom_g.txt

    rm -rf HLA_g_group
    rm -rf HLA_g_group_org
    ```

- Please execute [`g_group_build.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/HLA_analysis/Scripts/g_group_build.sh) in HLA_analysis/Scripts folder:

    ```bash
    # bash g_group_build.sh [g group list file name(No file extension required)]
    bash g_group_build.sh hla_nom_g
    ```


4. Compare HLA genotype
- Please execute [`hla_analysis.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/HLA_analysis/Scripts/hla_analysis.sh) in HLA_analysis/Scripts folder:


    ```bash
    # bash hla_analysis.sh [data_type(compared tool)] [data_type(reference)] [preprocess_tool(compared tool)] [preprocess_tool(reference)]  [compared tool] [reference] [sample number] [HLA_wgs folder path] [sample list file name(No file extension required)] [sample list file name(No file extension required)]
    # example:
    bash hla_analysis.sh WGS WGS Sentieon None hisatgenotype reference 5 ~/TWB_HLA/Test/Analyzed_data/HLA_wgs sample_list sample_list
    ```
5. The produced comparison result is in the HLA_wgs folder [`sensitivity_with_reference_[sample number].txt`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_result/HLA_wgs/sensitivity_with_reference_5.txt)

#### HLA genotype labeling (depend on Linux)
#### -- Results of the suggested HLA genotyping workflow
####
![](https://i.imgur.com/rqiUmXv.png)
1. Extract HLA genotyping data (2-field resolution) from HISAT-genotype and HLA-VBSeq
- Please execute [`get_result.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/HLA_analysis/Scripts/get_result.sh) in HLA_analysis/Scripts folder:

    ```bash
    # bash get_result.sh [data_type(tool)] [preprocess_tool(tool)] [tool] [sample number] [HLA_wgs folder path] [sample list file name(No file extension required)]
    bash get_result.sh WGS Sentieon hisatgenotype 5 ~/TWB_HLA/Test/Analyzed_data/HLA_wgs sample_list
    bash get_result.sh WGS Sentieon hlavbseq 5 ~/TWB_HLA/Test/Analyzed_data/HLA_wgs sample_list
    ```
2. Label HLA genotype (allele pair as a unit)
- HISAT-genotype
    - HLA-A, B, C, DPA1, DPB1, DQA1 and DQB1 genotype with labeling
- HLA-VBSeq
    - HLA-C and DPA1 genotype
- Please execute [`hla_genotype_labeling.sh`](https://github.com/yixuan-429/TWB_HLA/blob/main/HLA_analysis/Scripts/hla_genotype_labeling.sh) in HLA_analysis/Scripts folder:

    ```bash
    # bash hla_genotype_labeling.sh [data_type(HISAT-genotype)] [data_type(HLA-VBSeq)] [preprocess_tool(HISAT-genotype)] [preprocess_tool(HLA-VBSeq)] [HLA_wgs folder path] [sample list file name(No file extension required)] [sample number]
    bash hla_genotype_labeling.sh WGS WGS Sentieon Sentieon ~/TWB_HLA/Test/Analyzed_data/HLA_wgs sample_list 5
    ```
3. The produced labeling result is in the HLA_wgs folder [`hla_genotyping_labeling_d4_[sample number].csv`](https://github.com/yixuan-429/TWB_HLA/blob/main/Test/Analyzed_result/HLA_wgs/hla_genotyping_labeling_d4_5.csv)

#### Test for HLA genotype comparison and labeling
*  [Test data](https://github.com/yixuan-429/TWB_HLA/tree/main/Test/Analyzed_data/HLA_wgs)
*  [Test result](https://github.com/yixuan-429/TWB_HLA/tree/main/Test/Analyzed_result/HLA_wgs)
* Perform step 4 in HLA genotype comparison and all steps in HLA genotype labeling using test data
* If the result in `Test data` is the same as the result in `Test result`, it means success
#### Reference

- [HISAT-genotype](https://github.com/DaehwanKimLab/hisat-genotype)
- [HLA-VBSeq](http://nagasakilab.csml.org/hla/)
- [Kourami](https://github.com/Kingsford-Group/kourami)
- [HLA*LA](https://github.com/DiltheyLab/HLA-LA)

#!/bin/bash

### QC: Rawdata to CleanData

mkdir 00_RawData 01_CleanData

#Before performing the metagenomic pipeline, copy the raw sequencing data into the directory '00_Rawdata'.
cd ${CleanData}

##QC: filter low quality sequence by fastp 
${fastp} -i ${RawData}/${SampleID}_1.raw.fq.gz \
-o ${SampleID}.clean_R1.fastq.gz \
-I ${RawData}/${SampleID}_2.raw.fq.gz \
-O ${SampleID}.clean_R2.fastq.gz -h ${SampleID}.filt.html \
-j ${SampleID}.filt.json \
--cut_by_quality3 \
-W 4 -M 20 -n 5 -c -l 50 -w 3

### QC: filt host sequence
#index of reference genome
${bowtie2_build} ${Ref} ./Ref/contamination_ref.db

#paired
${bowtie2} -x ./Ref/contamination_ref.db --very-sensitive -p 20 \
	-1 01_CleanData/${sampleID}_clean_R1.fq \
	-2 01_CleanData/${sampleID}_clean_R2.fq \
	--un-conc 02_Removed_Host/${sampleID}_paired_clean%.fq \
	--al-conc 02_Removed_Host/${sampleID}_paired_contam%.fq

### seqkit stats fastq 

seqkit stats *.fastq >> fastq.stats.txt
#!/bin/bash
### Assembly: CleanData to Contigs MEGAHIT v1.2.9

${metawrap assembly} -1 ${CleanData}/${SampleID}_final_R1.fastq.gz \
-2 ${CleanData}/${SampleID}_final_R2.fastq.gz \
-t 128 \
-m 300 \
--min-contig-len 500 \
-o ${Assembly}/${SampleID}_megahit

cp ${SampleID}_megahit/final.contigs.fa ${Contigs}/${SampleID}.fa


### Assembly quality was checked using Quast v5.3.0 

$ quast.py assembly.fasta -o quast_output

### seqkit stats fasta 

$ seqkit stats *.fasta >> fasta.stats.txt

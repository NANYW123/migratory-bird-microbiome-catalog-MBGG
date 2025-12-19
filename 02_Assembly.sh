#!/bin/bash
### Assembly: CleanData to Contigs

${megahit} -1 ${CleanData}/${SampleID}_final_R1.fastq.gz \
-2 ${CleanData}/${SampleID}_final_R2.fastq.gz \
--min-count 2 \
--k-min 27 \
--k-max 87 \
--k-step 10 \
--num-cpu-threads 20 \
--min-contig-len 500 \
-o ${Assembly}/${SampleID}_megahit

cp ${SampleID}_megahit/final.contigs.fa ${Contigs}/${SampleID}.fa


### Assembly quality was checked using Quast 

$ quast.py assembly.fasta -o quast_output

### seqkit stats fasta 

$ seqkit stats *.fasta >> fasta.stats.txt

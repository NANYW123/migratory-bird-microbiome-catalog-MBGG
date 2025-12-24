#!/bin/bash

### ARGs-OAP3 stage_one ARGs-OAP3 v3.1.1
 
$args_oap stage_one -i input -o output -f fa -t 8

## ARGs-OAP3 stage_two

$args_oap stage_two -i ~/ARGs-OAP3-stage_one -t 96 -o ARGs-OAP3-stage_two --e 1e-7 --id 90 --qcov 75 --length 25

### MGEs

bbmap.sh ref=~/MobileGeneticElementDatabase/MGEs_FINAL_99perc_trim.fasta in=~/clean-data/${i}_paired_clean_1.fq in2=~clean-data/${i}_paired_clean_2.fq covstats=~/MGEs-bbmap/${i}_covstats.cov rpkm=~/MGEs-bbmap/${i}_rpkm.txt idtag=t ambiguous=best minid=0.95 nodisk
#!/bin/bash

### SCAPP
#step1:
mkdir SCAPP-k119.fastg
$megahit_toolkit contig2fastg 119 ~/ASSEMBLY/$i/megahit/intermediate_contigs/k119.contigs.fa > ~/SCAPP-k119.fastg/$i.k119.fastg

#step2:
mkdir scapp-result
$scapp -g ~/SCAPP-k119.fastg/$i.k119.fastg -o ~/scapp-result/$i -r1 ~/${i}_paired_clean_1.fastq -r2 ~/${i}_paired_clean_2.fastq -p 64

### MOB-suite

$mob_recon --infile /public/home/061331/metagenome/bird-combine/scapp-plasmid-sequence/$i --outdir /public/home/061331/metagenome/bird-combine/mob_recon-suit/$i

### Plasmidfinder

$plasmidfinder.py -i ${name} -l 0.6 -t 0.8 -p $path/plasmidfinder_db -o .

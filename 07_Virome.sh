#!/bin/bash

### virsorter2
$virsorter run -w ./step1-virsorter2_result/$i -i ${Assembly}/${i}_megahit/ --include-groups "dsDNAphage,ssDNA" -j 64 --min-length 5000 --min-score 0.8 --rm-tmpdir --viral-gene-required all

### checkv
$checkv end_to_end ./step1-virsorter2_result/$i/final-viral-combined.fa ./step2-checkv_result/$i -t 64 -d ./checkv-db-v1.4

###  virsorter2
cat ./step2-checkv_result/$i/proviruses.fna ./step2-checkv_result/$i/viruses.fna > ./step2-checkv_result/$i/combined.fna

$virsorter run -w ./step3-vs2-pass2/$i -i ./step2-checkv_result/$i/combined.fna --include-groups "dsDNAphage,ssDNA" -j 96 --min-length 5000 --min-score 0.8 all --rm-tmpdir --viral-gene-required --exclude-lt2gene --prep-for-dramv --seqname-suffix-off --viral-gene-enrich-off

###  vibrant
$python3 VIBRANT_run.py -no_plot -virome -t 40 -i ./vOTU.fa -folder ./vibrant_out -t 64

### vcontact2
$vcontact2 --raw-proteins ./vOTU.phages_combined-new.faa --rel-mode 'Diamond' --proteins-fp ./viral_genomes_g2g.csv --db 'ProkaryoticViralRefSeq94-Merged' --pcs-mode MCL --vcs-mode ClusterONE --c1-bin ./cluster_one-1.0.jar --threads 128 --output-dir ./vContact2

### genomad
$genomad end-to-end --cleanup --splits 8 ./vOTU.phages_combined.fna step9-genomad_output2 ./genomad_db --threads 128

### iphop
$iphop predict --fa_file ./step3-vs2-pass2/$i/final-viral-combined.fa --db_dir ./db/iphop_db/Sept_2021_pub_rw/ --out_dir step6-iphop_output/$i --num_threads 50 --min_score 90

### DRAM-v

# step 1 annotate
$DRAM-v.py annotate -i vs2-pass2/for-dramv/final-viral-combined-for-dramv.fa -v vs2-pass2/for-dramv/viral-affi-contigs-for-dramv.tab -o dramv-annotate --skip_trnascan --threads 28 --min_contig_size 1000

#step 2 summarize anntotations
$DRAM-v.py distill -i dramv-annotate/annotations.tsv -o dramv-distill

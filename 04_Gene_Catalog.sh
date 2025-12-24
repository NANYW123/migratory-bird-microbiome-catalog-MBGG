#!/bin/bash
### Construction of the gene catalog

cd ${GeneCatalog}
mkdir 01_before_cdhit 02_cdhit_cluster

### Gene prediction Prodigal v2.6.3 
cd 01_before_cdhit

${prodigal} -a allSample_protein.faa -d allSample_nucl.fna -o allSample_gff -p meta -i ../../${Assembly}/allSample.final_contigs.fasta


cd ${GeneCatalog}/02_cdhit_cluster

### dereplication at protein level (identity:100%-95%-50%) cd-hit v4.8.1 

$cdhit -i ${faa} -o total.protein.faa.100 -c 1.00 -n 5 -M 80000 -d 0 -T 16 && \
     cd-hit -i total.protein.faa.100 -o total.protein.faa.95 -c 0.95 -aS 0.9 -G 0 -s 0.8 -n 5 -M 20000 -g 1 -d 0 -T 64 && \
     cd-hit -i total.protein.faa.95 -o total.protein.faa.50 -c 0.5 -s 0.8 -n 3 -M 80000 -g 1 -d 0 -T 16     

cat total.protein.faa.95|grep "^>"|awk -F ' ' '{print $1}'|awk -F '>' '{print $2}' >MBGG90_geneID.list








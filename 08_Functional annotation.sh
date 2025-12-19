#!/bin/bash
### DRAM
$DRAM.py annotate -i './*.fa' -o DRAM-annotation-result --threads 54

### CARD
$rgi main -i ./$faa -o CARD/$faa.card -n 6 --debug -t protein -a DIAMOND --clean

### ResFinder
$python3 run_resfinder.py -ifa ${name} -s 'salmonella' -l 0.6 -t 0.8 --acquired -o ${name%.fasta}_result && mv ${name%.fasta}_result $path/ResFinder_result 

### Plasmidfinder
$python plasmidfinder.py -i ${name} -l 0.6 -t 0.8 -p $path/plasmidfinder_db -o . -x && mv results_tab.tsv ${name%.fasta}_tab.tsv && mv ${name%.fasta}_tab.tsv $path/Plasmidfinder

### MobileElementFinder
$mefinder find --min-coverage 0.9 --min-coverage 0.95 -c ${name} -g -t 96 ${name%.fasta} 

### AntiSMASH
$antismash --taxon bacteria --output-dir ~/antismash-result/$i --databases ~/antismash/databases --genefinding-tool prodigal-m --cb-general --cb-knownclusters --cb-subclusters --asf --pfam2go --smcog-trees --cpus 50 ~/all_bins/$i

### MetaPhlAn4
$metaphlan \
    ~/clean-data/${i}_paired_clean_1.fq,~/clean-data/${i}_paired_clean_2.fq \
    --nproc 64 --input_type fastq \
    -o ./metaphlan4/${i}.txt \
    --bowtie2db ~/MetaPhlAn4-database/ \
    --index  \
    --bowtie2out ./metaphlan4/metagenome.bowtie2_c.bz2

### eggNOG-mapper
$python emapper.py -i ~/${i}.fa --output ~/$i -m diamond e-value threshold 0.001

### VFDB
$abricate --db salmonella ${name} > ../${name}.tab && mv ../${name}.tab $path/VFDB_result

###metaVF 2.0
$metaVF.py -p ~/MetaVF_toolkit-main -pjn draft_test -id ~/magpurify-clean-bin_genomes -o ~/MetaVF-result/ -m draft -c 10 -ti 90 -tc 80


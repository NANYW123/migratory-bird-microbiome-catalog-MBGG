#Here, we build a high-quality migratory bird microbial genome and gene (MBGG) catalog that includes 5,823 metagenome-assembled genomes (MAGs), 13,072 plasmid sequences, and 44,974 viral genomes, which represent 1,709 candidate species spanning 36 phyla.

### Title: A genomic catalog of migratory microbiomes from wild birds across China’s habitats

This directory contains scripts related to the manuscript "A genomic catalog of migratory microbiomes from wild birds across China’s habitats". Before running, you must ensure that all required software and databases are installed successfully.

How to Reference?
If you have used this script in your research, please use the following link for references to our script: https://github.com/NANYW123/migratory-bird-microbiome-catalog-MBGG.git. Please also cite the corresponding software and <A genomic catalog of migratory microbiomes from wild birds across China’s habitats>.

Software and database installation
Most of the softwares can be installed through conda. The installation method refers to the manual of each software. The following published software is used in the pipeline. The name, version, and availability of the software are as follows:

Software	Availability

fastp v0.23.4 (https://github.com/OpenGene/fastp)

Bowtie2 v2.3.4 (https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.0/)

MEGAHIT v1.2.9 (https://github.com/voutcn/megahit)

Quast v5.3.0 (https://github.com/ablab/quast)

metaWRAP v1.3.2 (https://github.com/bxlab/metaWRAP)

CheckM v1.2.2 (https://github.com/Ecogenomics/CheckM)

CheckM2 v1.1.0 (https://github.com/chklovski/CheckM2)

MAGpurify v2.1.2 (https://github.com/snayfach/MAGpurify) 

dRep v3.4.2 (https://github.com/MrOlm/drep)

GTDB-Tk v2.3.2 (https://github.com/Ecogenomics/GTDBTk) 

CompareM v0.1.2 (https://github.com/dparks1134/CompareM) 

The fastANI v1.1 (https://github.com/ParBLiSS/FastANI) 

PhyloPhlAn 3.1.1 (https://github.com/biobakery/phylophlan)

cd-hit v4.8.1 (https://github.com/weizhongli/cdhit)

eggNOG-mapper v2.1.13 (https://github.com/eggnogdb/eggnog-mapper)

VirSorter2 v2.2.4 (https://bitbucket.org/MAVERICLab/virsorter2)

CheckV v1.0.1 (https://bitbucket.org/berkeleylab/checkv/src/master/)

VIBRANT v1.2.1 (https://github.com/AnantharamanLab/VIBRANT)

Prodigal v2.6.3 (https://github.com/hyattpd/Prodigal)

vConTACT2 (https://bitbucket.org/MAVERICLab/vcontact2/src/master/)

GeNomad (https://github.com/apcamargo/genomad/)

iPHoP v1.3.3 (https://bitbucket.org/srouxjgi/iphop/src/main/)

ABRicate v1.0.1 (https://github.com/tseemann/abricate/)

RGI v6.0.3 (https://github.com/arpcard/rgi)

PlasmidFinder v2.0.1 (https://github.com/kcri-tz/plasmidfinder) 

MetaPhlAn4 v4.1.1 (https://github.com/biobakery/MetaPhlAn)

ARGs-OAP3 v3.1.1 (https://github.com/alienzj/args_oap)

SCAPP v0.1.4 (https://github.com/Shamir-Lab/SCAPP)

metaVF (https://github.com/Wanting-Dong/MetaVF_toolkit)

MOB-suite v3.1.9 (https://github.com/phac-nml/mob-suite)

ResFinder v4.1 (https://bitbucket.org/genomicepidemiology/resfinder/src/master/)

MobileElementFinder v1.1.2 (https://bitbucket.org/mhkj/mge_finder/src/master/)

AntiSMASH v7.1.0.1 (https://github.com/antismash/antismash)

BiG-SCAPE v1.1.9 (https://github.com/medema-group/BiG-SCAPE

DRAM (https://github.com/shafferm/DRAM) 

KEGG (https://www.genome.jp/kegg/)

CAZyme (http://www.cazy.org/)

VOG (https://vogdb.org/)  

iTOL v7.0 (https://itol.embl.de/)

 
Note: The version are only the version used in the paper, most of database are constantly updated.
OVERVIEW OF PIPELINE
The scripts of whole-genome sequencing analysis are placed in "Pipeline" directory. 

Part1: 01_data_preprocessing.sh

Part2: 02_Assembly.sh

Part3: 03_genome_reconstruction.sh

Part4: 04_Gene_Catalog.sh

Part5: 05_resistome-MGE.sh

Part6: 06_plasmidome.sh

Part7: 07_Virome.sh

Part8: 08_Functional annotation.sh

Limitations: 
This workflow was designed specifically for "A genomic catalog of migratory microbiomes from wild birds across China’s habitats"; editing and revisions might be required before applying to other projects.

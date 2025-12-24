#!/bin/bash
### Binning: Contigs to MAGs
##use several modules of metawrap pipeline metaWRAP v1.3.2

mkdir ${Binning}/${SampleID}
cd ${Binning}/${SampleID}
mkdir INITIAL_BINNING BIN_REFINEMENT BIN_REASSEMBLY

source activate ~/miniconda3/envs/metawrap-env/

### binning with two different algorithms with the Binning module

$metawrap binning -o ./INITIAL_BINNING/$i -t 128 -m 300 -a ./ASSEMBLY/$i/final_assembly.fasta --metabat2 ${CleanData}/${SampleID}_final_R*.fastq.gz
$metawrap binning -o ./INITIAL_BINNING/$i -t 128 -m 300 -a ./ASSEMBLY/$i/final_assembly.fasta --maxbin2 ${CleanData}/${SampleID}_final_R*.fastq.gz
$metawrap binning -o ./INITIAL_BINNING/$i -t 128 -m 300 -a ./ASSEMBLY/$i/final_assembly.fasta --concoct ${CleanData}/${SampleID}_final_R*.fastq.gz

### Consolidate bin sets with the Bin_refinement module
$metawrap bin_refinement -o ./binning_refinement/$i -A ./INITIAL_BINNING/$i/metabat2_bins -B ./INITIAL_BINNING/$i/maxbin2_bins -C ./INITIAL_BINNING/$i/concoct_bins -t 128 -c 50 -x 10

### Re-assemble the consolidated bin set with the Reassemble_bins module
metawrap reassemble_bins -o ./BIN_REASSEMBLY/$i -1 ${CleanData}/${SampleID}_final_R1.fastq.gz -2 ${CleanData}/${SampleID}_final_R2.fastq.gz -c 50 -x 10 -b ./binning_refinement/$i/metawrap_50_10_bins -t 128 -m 300


### rename bin name:prefix SampleID
for i in $(ls *.fa);do mv $i ${SampleID}_${i};done

### magpurify v2.1.2 

$magpurify clean-bin ~/link_all_bins/$i ./output ~/magpurify-clean-bin_genomes/$i

### checkm2 v1.1.0
$checkm2 predict -i ~/magpurify-clean-bin_genomes/ -o ./checkm2_result --database_path ~/checkm2db/CheckM2_database/uniref100.KO.1.dmnd --threads 64 --force

### MAG de-replication dRep v3.4.2

### copy all fasta file of MAG to target directory
cp ${Binning}/${SampleID}/*.fa ${MAG}

### MAG de-replicate
${dRep} dereplicate ${dRep99} -g ${MAGs}/*.fa -p 16 -d -comp 50 -con 5 -nc 0.25 -pa 0.9 -sa 0.99
${dRep} cluster ${dRep95} -p 16 -nc 0.25 -pa 0.9 -sa 0.95 -g ${MAGs}/*.fa

### Taxonomic classification GTDB-Tk v2.3.2 
$gtdbtk classify_wf --cpus 50 --out_dir gtdbtk --genome_dir ../${genomes} --extension fa

### Phylogenetic analysis PhyloPhlAn 3.1.1
$phylophlan -i ../${genomes} -d ${phylophlan} --diversity high -f ${cfg} --accurate -o ${OUTPUT} --nproc 50


### Genome annotation prokka v1.14.5
source activate ~/miniconda3/envs/prokka_env

for i in $(ls ${genomes}/*.fa)
do
file=${i##*/}
ID=${file%.*}
prokka $i --prefix $ID --metagenome --kingdom Bacteria --outdir ${prokka_Result}
done


### comparem v0.1.2

$comparem aai_wf --cpus 50 ./dereplicated_genomes/ comparem-result-drep


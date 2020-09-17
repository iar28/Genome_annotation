#!/usr/bin/env bash

#SBATCH --partition=long
#SBATCH --mem=20G
#SBATCH --cpus-per-task=12


#taken and modified from the bioinformaticsworkbook tutorial. 
#after trimming the rnaseq data, run this script to align it to the masked genome 

#note variable DBDIR does not need a "/" at the end. 

#sh runAlignConvertSortStats.sh 20 sequence_1.fastq seqeunce_2.fastq 
#/work/GIF/remkv6/files genome.fa

export MYCONDAPATH=/home/illorens/miniconda3

source ${MYCONDAPATH}/bin/activate testenv 

export DATA=../../projects/ensa/plants/D_glom

cd ${DATA}


GENOME=$1



#hisat2-build ${GENOME} ${GENOME%.*}

hisat2 -p 12 -x ${GENOME%.*} -1 SRR638456${SLURM_ARRAY_TASK_ID}.clean_1.fastq.gz -2 SRR638456${SLURM_ARRAY_TASK_ID}.clean_2.fastq.gz -S SRR638456${SLURM_ARRAY_TASK_ID}.sam 

#Convert sam to bam, and sort 

#samtools view -@ 12 -bS SRR6384561.sam| samtools sort -o  SRR6384561.bam


samtools view --threads 12 -b -o SRR638456${SLURM_ARRAY_TASK_ID}.bam SRR638456${SLURM_ARRAY_TASK_ID}.sam

samtools sort -m 7G -o SRR638456${SLURM_ARRAY_TASK_ID}_sorted.bam -T SRR638456${SLURM_ARRAY_TASK_ID}_temp --threads 12 SRR638456${SLURM_ARRAY_TASK_ID}.bam 



conda deactivate

#Check alignment quality with Picard

#java -jar picard.jar CollectAlignmentSummaryMetrics \
# REFERENCE_SEQUENCE=${DBDIR}/${GENOME} INPUT=${R1_FQ%.*}_sorted.bam \
# OUPUT=${R1_FQ%.*}.bam_alignment.stats

#!/usr/bin/env bash

#SBATCH --partition=short
#SBATCH --time=0-03:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=12


export MYCONDAPATH=/home/illorens/miniconda3

source ${MYCONDAPATH}/bin/activate testenv 

export DATA=../../projects/ensa/plants/D_glom/rna-seq/rnaseq_pairend/

cd ${DATA}


#Preprocess rnaseq data downloaded from SRA for annotating the Datisca genome

#Run FASTQ before trimming and aligning
DATE=fastqc_results_SRR638456${SLURM_ARRAY_TASK_ID}$(date +%y%m%d)
mkdir ${DATE}

fastqc --threads 12 SRR638456${SLURM_ARRAY_TASK_ID}_1.fastq.gz SRR638456${SLURM_ARRAY_TASK_ID}_2.fastq.gz --outdir ${DATE}


#trim 

bbduk.sh  in1=SRR638456${SLURM_ARRAY_TASK_ID}_1.fastq.gz in2=SRR638456${SLURM_ARRAY_TASK_ID}_2.fastq.gz out1=SRR638456${SLURM_ARRAY_TASK_ID}.clean_1.fastq.gz out2=SRR638456${SLURM_ARRAY_TASK_ID}.clean_2.fastq.gz ref=~/bin/bbmap/resources/adapters.fa k=23 ktrim=r useshortkmers=t mink=11 qtrim=r trimq=10 minlength=20 ftl=15 ftr=73 t=12


#Run FASTQ on trimmed samples

echo "Run FastQC"

fastqc --threads 12 SRR638456${SLURM_ARRAY_TASK_ID}.clean_1.fastq.gz SRR638456${SLURM_ARRAY_TASK_ID}.clean_2.fastq.gz --outdir ${DATE}

conda deactivate


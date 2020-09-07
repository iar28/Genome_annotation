# Genome_annotation
# Scripts for genome annotation

 This repository contains the instructions and scripts for annotating a genome based on the Braker2 pipeline. 
 For more information about Braker2 and the tutorial you can log into: https://bioinformaticsworkbook.org/dataAnalysis/GenomeAnnotation/Intro_to_Braker2.html#gsc.tab=0

# Requirements:

Make sure you have installed the following packages using conda (with their dependencies):

#bbmap
#fastqc
#repeatmasker
#repeatmodeler
...



 As mentioned in the tutorial these are the general steps for annotating a genome with Braker2

Prerequisite data for prediction
Gather all transcriptional data for your organism, (ESTs, RNA-seq, Transcripts, Isoseq) (required)
Gather all proteins for your organism
Gather repeat libraries for genome masking
Get your genome (required)
Prepare repeat masking and genome alignments
Create repeats library and softmask your genome with RepeatMasker
Trim and align your RNA-seq data to your genome
Align transcripts, ESTs, or other long transcriptional reads to genome with splice aware aligner
Convert Sam to Bam and sort
Run Braker2



#!/usr/bin/env bash 


#SBATCH --partition=long
#SBATCH --mem=50G
#SBATCH --cpus-per-task=20


d=$1

export MYCONDAPATH=/home/illorens/miniconda3
source ${MYCONDAPATH}/bin/activate testenv  
export DATA=~/../../projects/ensa/plants/final_assemblies_080920

cp -r ${DATA}/${d}/ ~/../../tmp/

cd ~/../../tmp/${d}/


BuildDatabase -name ${d}.DB -engine rmblast *.fasta

RepeatModeler -database ${d}.DB -engine ncbi -pa 20 


# I had an error because some databases were not included during the installation 
#had to install them manually and run RepeatClassifier manually using the following parameters

#(testenv) illorens@compute02:/tmp/repeatmodeler$ RepeatClassifier -pa 20  -consensi RM_251057.MonSep70915132020/consensi.fa -stockholm RM_251057.MonSep70915132020/families.stk

ln -s RM_*/consensi.fa.classified 
RepeatMasker -pa 20 -gff -lib consensi.fa.classified *.fasta

mv  ~/../../tmp/${d} ${DATA}/output_masker
conda deactivate 
exit


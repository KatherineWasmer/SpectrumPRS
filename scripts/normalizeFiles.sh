#!/bin/bash
#SBATCH --job-name=normalize
#SBATCH --output=normalize_%A_%a.out
#SBATCH --error=normalize_%A_%a.err
#SBATCH --array=0-21
#SBATCH --time=1:00:00
#SBATCH --mem=8G

cd ~/Capstone
module load Bioinformatics 
module load bcftools 
module load samtools 
module load htslib 

# Get sorted files for this task in GrCh37 format 
file=$(sed -n "$((SLURM_ARRAY_TASK_ID + 1))p" to_normalize.txt)
echo "Processing $file..."

base=$(basename "$file" .vcf.gz)
tabix -p vcf "$file"

bcftools norm --check-ref s \
    --fasta-ref hg19.fa \
    --multiallelics - \
    -Oz -o ${base}.norm.vcf.gz \
    "$file"

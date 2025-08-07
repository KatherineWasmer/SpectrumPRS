#!/bin/bash
#SBATCH --job-name=ancestry_LaSalle
#SBATCH --output=ancestry_%A_%a.out
#SBATCH --error=ancestry_%A_%a.err
#SBATCH --array=0-9
#SBATCH --time=2:00:00
#SBATCH --mem=8G

cd ~/Capstone

# Get sorted files for this task in GrCh37 format 
file=$(sed -n "$((SLURM_ARRAY_TASK_ID + 1))p" sorted_files.txt)
echo "Processing $file..."

base=$(basename "$file" .vcf.gz)

# rename chromosomes for AEon format 
renamed_chr_file = "GSE178204_RAW/${base}_chr.vcf.gz"
bcftools annotate --rename-chrs rename_chr.txt -Oz -o $renamed_chr_file $file

# intersect allele frequencies with given SNPs 
intersected_file = "${base}_intersectedAFs.txt"
bedtools intersect -a g1k_allele_freqs.txt -b A106109_cleaned_chr.vcf.gz -header > $intersected_file

# run ancestry 
aeon $renamed_chr_file -o $base -a $intersected_file

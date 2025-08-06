#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --mem=32G
#SBATCH --output=convertBCF_%A_%a.out
#SBATCH --error=convertBCF_%A_%a.err
cd ~/Capstone

module load Bioinformatics 
module load bcftools 
module load samtools 
module load htslib 
module load plink/1.9 

bcftools view merged_A.bcf -Oz -o merged_A.vcf.gz || { echo "bcftools failed"; exit 1; }

tabix -p vcf merged_A.vcf.gz || { echo "tabix failed"; exit 1; }

bcftools view -e 'REF=ALT' merged_A.vcf.gz -Oz -o merged_A_cleaned.vcf.gz
bcftools index merged_A_cleaned.vcf.gz
plink --vcf merged_A_cleaned.vcf.gz --make-bed --out merged_A

rm merged_A.bcf 
rm merged_A.vcf.gz 
rm merged_A.vcf.gz.tbi 

plink --bfile merged_A --keep-allele-order --pca 20 --out merged_A_PCA

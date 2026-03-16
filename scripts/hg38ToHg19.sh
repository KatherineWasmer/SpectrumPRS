#!/bin/bash

module load Bioinformatics 
module load bcftools 
module load samtools 
module load htslib 

# error message included when debugging through ChatGPT 
if [ $# -lt 1 ]; then
  echo "Usage: $0 input.vcf.gz"
  exit 1
fi

# Syntax errors were fixed through ChatGPT (e.g., reformatting base file names, spacing, etc.) 
input_file=$1
base_name=$(basename "$input_file" .vcf.gz)
output_file="${base_name}_lifted.vcf.gz"

CrossMap.py vcf hg38ToHg19.over.chain "$input_file" hg19.fa "$output_file"

lifted_base=$(basename "$output_file" .vcf.gz)
sorted_file="${lifted_base}_sorted.vcf.gz"
bcftools sort "$output_file" -Oz -o "$sorted_file"
tabix -p vcf "$sorted_file"

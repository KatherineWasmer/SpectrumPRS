#!/bin/bash

module load Bioinformatics 
module load bcftools 
module load samtools 
module load htslib 

input_file=$1
base_name=$(basename "$input_file" .vcf.gz)
output_file="${base_name}_at.vcf.gz"
# filter autosomes (no spaces between commas) 
bcftools view -r 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22 -Oz -o "$output_file" "$input_file"
tabix -p vcf "$output_file"

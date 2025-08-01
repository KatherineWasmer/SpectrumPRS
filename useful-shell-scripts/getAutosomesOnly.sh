#!/usr/bin/env bash
# fix later for efficiency and calling other shell scripts 

module load Bioinformatics 
module load bcftools 
bcftools view -r chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,\
  chr11,chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr21,chr22 \
  -Oz -o A102092_sorted_at.vcf.gz A102092_sorted.vcf.gz

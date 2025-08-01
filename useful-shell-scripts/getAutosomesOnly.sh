#!/usr/bin/env bash
# run this through ChatGPT later for debugging 

module load Bioinformatics 
module load bcftools 
module load samtools 
module load htslib 

pfx = "sorted" 
at = "at" # autosomal 
# sort vcf 
bcftools sort $1 -Oz -o {$pfx}{$1}
# index sorted vcf 
tabix -p vcf {$pfx}{$1}
# filter autosomes (no spaces between commas) 
bcftools view -r chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr21,chr22 -Oz -o {$at}{$pfx}{$1}

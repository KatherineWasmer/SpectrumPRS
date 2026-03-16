#!/usr/bin/env bash

module load Bioinformatics 
module load plink/1.9   
plink --bfile $1 --recode-vcf --out $1  

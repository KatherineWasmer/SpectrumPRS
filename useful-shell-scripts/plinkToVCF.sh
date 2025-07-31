#!/usr/bin/env bash

module load Bioinformatics 
module load plink/1.9 
myFile = $1 # Prefix of the BED/BIM/FAM files   
plink --bfile $myFile --recode-vcf --out $myFile  

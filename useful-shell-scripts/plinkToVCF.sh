#!/usr/bin/env bash

module load Bioinformatics 
module load plink/1.9 
echo Please enter the prefix of your BED/BIM/FAM files. These should all be the same. 
read myFile   
plink --bfile $myFile --recode-vcf --out $myFile  

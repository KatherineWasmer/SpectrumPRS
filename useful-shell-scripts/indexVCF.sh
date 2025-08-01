#!/usr/bin/env bash

module load Bioinformatics 
module load samtools 
module load tabix 

tabix -p vcf $1 

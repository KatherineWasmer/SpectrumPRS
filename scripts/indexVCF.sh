#!/usr/bin/env bash

module load Bioinformatics 
module load samtools 
module load htslib

tabix -p vcf $1 

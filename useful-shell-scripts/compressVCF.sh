#!/usr/bin/env bash

module load Bioinformatics 
module load bcftools 
extension = ".vcf.gz"
bgzip -c $1 > {$1}{$extension}

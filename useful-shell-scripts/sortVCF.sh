#!/usr/bin/env bash

module load Bioinformatics 
module load bcftools
extension = "sorted" 
bcftools sort $1 -o {$sorted}{$1}

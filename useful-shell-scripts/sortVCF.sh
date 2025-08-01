#!/usr/bin/env bash

module load Bioinformatics 
module load bcftools
extension = "sorted" 
$1 # file name argument 
bcftools sort $1 -o {$sorted}{$1}

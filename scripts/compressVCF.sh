#!/usr/bin/env bash

module load htslib 
extension = ".vcf.gz"
bgzip -c $1 > ${1}${extension}

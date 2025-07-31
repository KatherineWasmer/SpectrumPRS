#!/usr/bin/env bash

module load bcftools 
echo Please input your VCF file. 
read myFile
extension = ".vcf.gz"
bgzip -c $myFile > ${myFile}${extension}



# rename chromosomes for AEon format 
bcftools annotate --rename-chrs rename_chr.txt -Oz -o A106109_cleaned_chr.vcf.gz A106109_cleaned.vcf.gz
# intersect allele frequencies with given SNPs 
bedtools intersect -a g1k_allele_freqs.txt -b A106109_cleaned_chr.vcf.gz -header > intersected_AFs.txt
# run ancestry 
aeon A106109_cleaned_chr.vcf.gz -o A106109 -a intersected_AFs.txt

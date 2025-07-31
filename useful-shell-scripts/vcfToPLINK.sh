module load Bioinformatics 
module load plink/1.9

plink --vcf myFile.vcf.gz --make-bed --out myFile --pheno myPhenos.txt

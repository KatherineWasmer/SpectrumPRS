# prs_autism
This is my source code for my capstone project, including any helper functions and commands that may be useful to other bioinformatics students! :) 

### Data sets and sampling  

[Saudi Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE221098)
- Cases: n = 22
- Controls: n = 51 

[Japanese Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144918)

[Converted PLINK binary format](https://drive.google.com/drive/folders/1lvV8p_2tUnx8iuFxe6-sSpm8CBmYSJs4) - credit to Genarchivist forum user teepean 
- Cases: n = 68
- Controls: n = 124

[LaSalle Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi)
- Cases: 41 
- Controls: 15

### Useful command lines 
#### Relevant modules 📂

```
module load Bioinformatics

module load plink/1.9

module load bcftools

module load samtools

module load htslib
```

#### Convert Plink binary to VCF ▶️

```
plink --bfile myFile --recode-vcf --out myFile

# Compress vcf file

bgzip -c myFile.vcf > myFile.vcf.gz

# Index vcf

tabix -p vcf myFile.vcf.gz
```

#### Convert Plink VCF to binary ◀️ 

Note: phenotypes do not always cross over when converting files, so you will want to save your phenotype data to a text file (see data_cleaning.py). 

```
plink --file --vcf myFile.vcf.gz --make-bed --out myFile --pheno myPhenos.txt
```

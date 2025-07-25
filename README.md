# Polygenic Risk Scoring for ASD 
This is the source code for my MDS Capstone project at the University of Michigan. 

## Data sets and sampling  

[Saudi Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE221098)
- Cases: n = 22
- Controls: n = 51 

[Japanese Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144918) & [Converted PLINK binary format](https://drive.google.com/drive/folders/1lvV8p_2tUnx8iuFxe6-sSpm8CBmYSJs4) - credit to Genarchivist forum user teepean 
- Cases: n = 68
- Controls: n = 124

[LaSalle Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi)
- Cases: n = 41 
- Controls: n = 15

## Useful command lines 

Working with Linux on an HPC is a learning curve, so I compiled a masterlist of commands that are common in computational genomics. These may be helpful if you do any sort of scientific computing at the University of Michigan! 

### Relevant modules 📂

```
module load Bioinformatics

module load plink/1.9

module load bcftools

module load samtools

module load htslib

module load vcftools 
```

### Convert Plink binary to VCF ▶️

```
plink --bfile myFile --recode-vcf --out myFile
```

Compress vcf file 
```
bgzip -c myFile.vcf > myFile.vcf.gz
```

Sort vcf by base pair
```
bcftools sort myFile.vcf.gz
```

Index vcf for merging  
```
tabix -p vcf myFile.vcf.gz
```

Merge vcf files 
```
bcftools merge file1.vcf.gz file2.vcf.gz ... filen.vcf.gz -Oz -o merged.vcf.gz
```

### Convert Plink VCF to binary ◀️ 

Note: phenotypes do not always cross over when converting files, so you will want to save your phenotype data to a text file (see data_cleaning.py). 

```
plink --file --vcf myFile.vcf.gz --make-bed --out myFile --pheno myPhenos.txt
```

### Get .ped, .map, and .fam files 🗺️

(for unzipped files)
```
vcftools --vcf myFile.vcf --out myFile --plink
```

(for zipped files)
```
vcftools --gzvcf myFile.vcf.gz --out myFile --plink # for zipped files 
```

### Data cleaning and handling 🧹

Filter VCF only by common SNPs (useful for dimensionality reduction techniques). 

```
maf_threshold = 0.01 # can change to 0.05 if you want to reduce more 
bcftools view -m2 -M2 -v snps {myFile}.vcf.gz | \
bcftools filter -e 'INFO/AF < 0.01 || INFO/AF > 0.05' -Oz -o {myFile}.filtered.vcf.gz
```

Print the chromosomes included in the VCF file. Sometimes during merging, there can be errors that lead to missing chromosomes, so it's important to check this before running any analyses on your data set. 

```
bcftools view -H {myFile}.vcf.gz | cut -f1 | sort | uniq
```

### Run a local conda 🐍

Create conda environment 
```
module avail anaconda
module load anaconda/{myVersion}
conda create -n {myEnv} python={myVersion} -y
```

Initiate your environment 
```
conda activate {myEnv} 
```

# Polygenic Risk Scoring for ASD 
This repository outlines the machine learning lifecycle for my capstone project, which was conducted from May 2025 to August 2025. I will make occasional updates to refine my code and to organize the repository for the most user-friendly experience. 

## Table of Contents 
[Defining the Problem](https://github.com/KatherineWasmer/SpectrumPRS/blob/main/README.md#1-defining-the-problem)

[Data Collection](https://github.com/KatherineWasmer/SpectrumPRS/blob/main/README.md#2-data-collection)

[Data Cleaning & Preprocessing](https://github.com/KatherineWasmer/SpectrumPRS/tree/main?tab=readme-ov-file#3-data-cleaning--preprocessing)


## 1. Defining the Problem 

Autism spectrum disorder (ASD) is a complex condition that does not have a single cause, but studies show that the majority of causal factors are genetic. One way to measure an individual's genetic predisposition to having ASD is to calculate their ***polygenic risk score*** (PRS). Let's break down what this term means, word by word. 

**Polygenic:** Autism is not caused by one single gene. Genome-wide association studies (GWAS) have identified numerous common genetic markers (MAF >= 0.05) that are associated with the disorder. 

**Risk:** For each GWAS-significant marker, we can identify the allele that increases the risk of the condition. An individual can have 0, 1, or 2 copies of a risk allele. The GWAS also provides an effect size of the genetic marker.  

**Score:** At each marker, we multiply the effect size by the count of risk alleles (0, 1, or 2). The summation across all markers returns the polygenic risk score. 


$PRS_{j} = \sum_{i=0}^{n}\beta_{i}x_{ij}$, where j denotes a single individual within the cohort. 

Using the PRS to predict the risk of autism, however, comes with its limitations. These variants are not usually causal, and the patterns of correlation between these genetic variants differ among different ancestral groups. Moreover, GWAS samples are ***heavily European***, which means that scores for individuals of non-European ancestry may not actually be accurate. My project aimed to study the portability of the PRS across underrepresented populations, and quantifying the accuracy of scores across these groups. 

## 2. Data collection 

Finding publicly available genomic datasets is not an easy task. Although I requested data from the Michigan Genomics Institute and filled out an IRB application, the duration of my project made it impossible to acquire this data. As an alternative, I collected data from published studies through the National Center for Biotechnology Information (NCBI). I used 3 different studies for my data collection, obtaining a sample of n = 320 individuals. 

### American Dataset (29 cases, 26 controls) 

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE178204

### Japanese Data (68 cases, 124 controls) 

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144918

### Saudi Dataset (22 cases, 51 controls) 

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE221098

## 3. Data Cleaning & Preprocessing 

1. Lift over any genotype data in GRCh38 form to GRCh37. For this project, the American dataset was in build GRCh38 and needed to be converted. Here is an example script from my terminal on the Great Lakes computing cluster: 

```
(base) [kwasmer@gl-login2 Capstone]$ ./hg38ToHg19.sh LaSalle/A102092.vcf.gz

--> returns an indexed, sorted file with the name LaSalle/A102092_lifted_sorted.vcf.gz
```

2. Convert all files to VCF. I have a script for converting IDAT files (e.g., the Saudi dataset) into a PLINK-compatible format.
3. Normalize all datasets to the hg19 fasta file to avoid reference mismatches
5. Reduce the datasets to only the 22 autosomes (excluding X and Y chromosomes for this project).
6. Index all of the datasets for merging.
7. Merge the files on the Galaxy server in BCF to conserve storage.

<img width="232" height="200" alt="image" src="https://github.com/user-attachments/assets/2a80c796-f501-4092-82f9-b7c902ecddb4" />


8. Convert BCF file back to VCF in the command line.
9. Create a PLINK binary file for the merged data 

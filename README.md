# Polygenic Risk Scoring for ASD 
This repository outlines the machine learning lifecycle for my capstone project, which was conducted from May 2025 to August 2025. I will make occasional updates to refine my code and to organize the repository for the most user-friendly experience. 

## 1. Defining the Problem 

Autism spectrum disorder (ASD) is a complex condition that does not have a single cause, but studies show that the majority of causal factors are genetic. One way to measure an individual's genetic predisposition to having ASD is to calculate their ***polygenic risk score*** (PRS). Let's break down what this term means, word by word. 

**Polygenic:** Autism is not caused by one single gene. Genome-wide association studies (GWAS) have identified numerous common genetic markers (MAF >= 0.05) that are associated with the disorder. 

**Risk:** For each GWAS-significant marker, we can identify the allele that increases the risk of the condition. An individual can have 0, 1, or 2 copies of a risk allele. The GWAS also provides an effect size of the genetic marker.  

**Score:** At each marker, we multiply the effect size by the count of risk alleles (0, 1, or 2). The summation across all markers returns the polygenic risk score. 

Using the PRS to predict the risk of autism, however, comes with its limitations. These variants are not usually causal, and the patterns of correlation between these genetic variants differ among different ancestral groups. Moreover, GWAS samples are ***heavily European***, which means that scores for individuals of non-European ancestry may not actually be accurate. My project aimed to study the portability of the PRS across underrepresented populations, and quantifying the accuracy of scores across these groups. 

## 2. Data collection 

Finding publicly available genomic datasets is not an easy task. Although I requested data from the Michigan Genomics Institute and filled out an IRB application, the duration of my project made it impossible to acquire this data. As an alternative, I collected data from published studies through the National Center for Biotechnology Information (NCBI). I used 3 different studies for my data collection, obtaining a sample of n = 320 individuals. 

### Japanese Data (68 cases, 124 controls) 

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144918

### Saudi Dataset (22 cases, 51 controls) 

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE221098

### American Dataset (29 cases, 26 controls) 

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE178204
